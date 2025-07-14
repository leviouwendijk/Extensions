import Foundation

extension String {
    public var strippingNorgMetadata: String {
        return self
        .replacingOccurrences(
            of: #"(?s)@document\.meta.*?@end"#,
            with: "",
            options: .regularExpression
        )
    }

    public var splitByNewlines: [String] {
        return self
        .components(separatedBy: .newlines)
    }

    public func collapsingDoubleSpaces() -> String {
        return self.replacingOccurrences(
            of: " {2,}",
            with: " ",
            options: .regularExpression
        )
    }
}
