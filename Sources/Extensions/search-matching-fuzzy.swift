// // moved to Structures

// import Foundation
// // import SwiftUI
// import plate

// extension String {
//     public var clientDogTokens: [String] {
//         normalizedForClientDogSearch
//             .components(separatedBy: CharacterSet.whitespacesAndNewlines)
//             .filter { !$0.isEmpty }
//     }
// }

// extension String {
//     public var asciiSearchNormalized: String {
//         var s = self
//             .applyingTransform(.toLatin, reverse: false)?
//             .applyingTransform(.stripCombiningMarks, reverse: false)
//             ?? self

//         let ligatures: [String: String] = [
//             "ß": "ss", "Æ": "AE", "æ": "ae",
//             "Œ": "OE", "œ": "oe"
//         ]

//         for (special, plain) in ligatures {
//             s = s.replacingOccurrences(of: special, with: plain)
//         }

//         let dashChars = CharacterSet(charactersIn: "–—−-") // en, em, minus, non-break
//         s = s.components(separatedBy: dashChars).joined(separator: "-")

//         let punct = CharacterSet.punctuationCharacters
//         s = s.components(separatedBy: punct).joined(separator: " ")

//         let comps = s
//             .components(separatedBy: CharacterSet.whitespacesAndNewlines)
//             .filter { !$0.isEmpty }
//         return comps.joined(separator: " ").lowercased()
//     }
// }

// extension String {
//     public func levenshteinDistance(to target: String) -> Int {
//         let s = Array(self)
//         let t = Array(target)
//         let m = s.count, n = t.count

//         if m == 0 { return n }
//         if n == 0 { return m }

//         // self[0..<i-1] and target[0..<j]
//         var prev = Array(0...n)
//         var curr = [Int](repeating: 0, count: n + 1)

//         for i in 1...m {
//             curr[0] = i
//             for j in 1...n {
//                 let cost = (s[i-1] == t[j-1]) ? 0 : 1
//                 // deletion:   prev[j] + 1
//                 // insertion:  curr[j-1] + 1
//                 // substitution: prev[j-1] + cost
//                 curr[j] = Swift.min(
//                     prev[j]     + 1,
//                     curr[j-1]   + 1,
//                     prev[j-1]   + cost
//                 )
//             }
//             // roll the rows
//             (prev, curr) = (curr, prev)
//         }
//         return prev[n]
//     }

//     public func highlighted(
//         _ tokens: [String], 
//         highlightColor: Color = .accentColor
//         // baseFont: Font = .body
//     ) -> AttributedString {
//         var attr = AttributedString(self)
//         let lower = self.lowercased()
//         for token in tokens {
//             var start = lower.startIndex
//             while let range = lower[start...].range(of: token) {
//                 let nsRange = NSRange(range, in: self)
//                 if let swiftRange = Range(nsRange, in: attr) {
//                     attr[swiftRange].foregroundColor = highlightColor
//                     // attr[swiftRange].font = .bold()
//                 }
//                 start = range.upperBound
//             }
//         }
//         return attr
//     }
// }
