import Foundation
import plate
import Structures

extension Date {
    static func today() -> Date {
        return Date()
    }
}

protocol DateDistanceCalculable {
    func distance(to date: Date, in units: DateDistanceUnit) -> DateComponents
}

extension Date: DateDistanceCalculable {
    public func distance(to date: Date, in unit: DateDistanceUnit) -> DateComponents {
        let calendar = Calendar.current
        
        switch unit {
        case .days:
            return calendar.dateComponents([.day], from: self, to: date)
            
        case .months:
            return calendar.dateComponents([.month], from: self, to: date)
            
        case .years:
            return calendar.dateComponents([.year], from: self, to: date)
            
        case .hours:
            return calendar.dateComponents([.hour], from: self, to: date)
            
        case .minutes:
            return calendar.dateComponents([.minute], from: self, to: date)
            
        case .seconds:
            return calendar.dateComponents([.second], from: self, to: date)
            
        case .milliseconds:
            let interval = date.timeIntervalSince(self)
            let millis = Int(interval * 1_000)
            return DateComponents(nanosecond: millis * 1_000_000)
            
        case .combined:
            return calendar.dateComponents(
                [.year, .month, .day, .hour, .minute, .second],
                from: self,
                to: date
            )
        }
    }
}

public enum TimeBetweenError: Error, LocalizedError {
    case invalidUnit
    case componentUnavailable(unit: DateDistanceUnit)
    
    public var errorDescription: String? {
        switch self {
        case .invalidUnit:
            return "Cannot use `.combined` when asking for a single integer."
        case .componentUnavailable(let unit):
            return "Calendar failed to produce a '\(unit.rawValue)' component."
        }
    }
}

public func timeBetween(
    from start: Date,
    to end: Date,
    in unit: DateDistanceUnit
) throws -> Int {
    let calendar = Calendar.current
    
    func singleComponent(_ comp: Calendar.Component, for unit: DateDistanceUnit) throws -> Int {
        let components = calendar.dateComponents([comp], from: start, to: end)
        guard let value = components.value(for: comp) else {
            throw TimeBetweenError.componentUnavailable(unit: unit)
        }
        return value
    }
    
    switch unit {
    case .days:
        return try singleComponent(.day,    for: .days)
    case .months:
        return try singleComponent(.month,  for: .months)
    case .years:
        return try singleComponent(.year,   for: .years)
    case .hours:
        return try singleComponent(.hour,   for: .hours)
    case .minutes:
        return try singleComponent(.minute, for: .minutes)
    case .seconds:
        return try singleComponent(.second, for: .seconds)
        
    case .milliseconds:
        let interval = end.timeIntervalSince(start)
        return Int(interval * 1_000)
        
    case .combined:
        throw TimeBetweenError.invalidUnit
    }
}
