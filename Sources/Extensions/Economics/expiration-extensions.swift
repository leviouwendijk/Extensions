import Structures

extension ExpirationDateRange {
    public func string(in format: String = "dd/MM/yyyy") -> String {
        return "\(start.conforming(to: format)) - \(end.conforming(to: format))"
    }
}
