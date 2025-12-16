import Foundation

extension Array {
    public func createIndex<T: Hashable, U>(
        from: KeyPath<Element, T>,
        to: KeyPath<Element, U>
    ) -> [T: U] {
        return self.reduce(into: [:]) { result, element in
            result[element[keyPath: from]] = element[keyPath: to]
        }
    }
}
