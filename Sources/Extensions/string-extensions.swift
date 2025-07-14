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

    public func emDashedFromHyphens() -> String {
        return self.replacingOccurrences(of: "--", with: "—")
    }

    // public func contexts(of substring: String) -> [(before: Character?, after: Character?)] {
    //     var results: [(Character?, Character?)] = []
    //     guard !substring.isEmpty else { return results }

    //     let full = Array(self)
    //     let pattern = NSRegularExpression.escapedPattern(for: substring)
    //     let re = try! NSRegularExpression(pattern: pattern)

    //     let ns = self as NSString
    //     let ranges = re.matches(in: self, range: NSRange(location: 0, length: ns.length))
    //     .map { $0.range }

    //     for range in ranges {
    //         let start = range.location
    //         let end = range.location + range.length - 1

    //         let before: Character? = (start > 0) ? full[start - 1] : nil

    //         let after: Character? = (end + 1 < full.count) ? full[end + 1] : nil

    //         results.append((before, after))
    //     }
    //     return results
    // }
}
