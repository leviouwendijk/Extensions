import Foundation
import plate
import Structures

extension Double {
    public func orient(to direction: ValueDirection) -> Double {
        switch direction {
            case .debit:
                return self
            case .credit: 
                return self * -1
        }
    }

    public var payableOrReceivableLabel: String {
        return self >= 0 ? "Te betalen" : "Te ontvangen"
    }
}
