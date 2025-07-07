import Foundation
import plate
import Contacts

public enum EmptyQueryBehavior {
    case none
    case all
}

extension Array where Element == CNContact {
    public func filteredClientContacts(
        matching query: String,
        uponEmptyReturn: EmptyQueryBehavior = .all,
        fuzzyTolerance: Int = 2,
        sortByProximity: Bool = true
    ) -> [CNContact] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return (uponEmptyReturn == .all) ? self : []
        }

        let tokens = trimmed.clientDogTokens

        let filtered = self.filter { contact in
            let haystack = contact.searchableWords()

            // each token must either be a substring OR within fuzzyTolerance of some haystack word
            return tokens.allSatisfy { token in
                haystack.contains(where: { word in
                    if word.contains(token) { return true }
                    return word.levenshteinDistance(to: token) <= fuzzyTolerance
                })
            }
        }

        guard sortByProximity else { return filtered }
        return filtered.sorted {
            $0.matchScore(tokens: tokens) < $1.matchScore(tokens: tokens)
        }
    }
}

extension CNContact {
    public func searchableWords() -> [String] {
        let fullName = "\(givenName) \(familyName)"
        .normalizedForClientDogSearch

        let email = (emailAddresses.first?.value as String? ?? "")
        .normalizedForClientDogSearch

        return (fullName + " " + email)
        .components(separatedBy: CharacterSet.whitespacesAndNewlines)
        .filter { !$0.isEmpty }
    }

    public func matchScore(tokens: [String]) -> Int {
        let haystack = self.searchableWords()

        return tokens.reduce(0) { sum, token in
            let best = haystack.map { word in
                word.contains(token)
                  ? 0
                  : word.levenshteinDistance(to: token)
            }.min() ?? Int.max
            return sum + best
        }
    }
}
