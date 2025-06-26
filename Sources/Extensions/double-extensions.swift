import Foundation
import plate
import Structures

public enum AccountBalancePolarity: Sendable {
    case payable
    case receivable

    public func overviewLabel() -> String {
        switch self {
            case .payable: 
                return "Te betalen"
            case .receivable: 
                return "Te ontvangen"
        }
    }

    public func documentLabel() -> String {
        switch self {
            case .payable: 
                return "Factuur"
            case .receivable: 
                return "Terugbetaling"
        }
    }
}

extension Double {
    public func orient(to direction: ValueDirection) -> Double {
        switch direction {
            case .debit:
                return self
            case .credit: 
                return self * -1
        }
    }

    public func payableOrReceivable() -> AccountBalancePolarity {
        return self >= 0 ? .payable : .receivable
    }
}
