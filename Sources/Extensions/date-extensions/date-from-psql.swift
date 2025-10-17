import Foundation
import Structures

// RFC3339 / Postgres-ish timestamptz helpers
private let _pgOut: DateFormatter = {
    let f = DateFormatter()
    f.locale = Locale(identifier: "en_US_POSIX")
    f.timeZone = TimeZone(secondsFromGMT: 0)          // emit Z by default
    f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"   // 2025-10-17T00:20:45.123Z
    return f
}()

private let _pgInFormats: [String] = [
    "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX",
    "yyyy-MM-dd'T'HH:mm:ssXXXXX",
    "yyyy-MM-dd HH:mm:ss.SSSXXXXX",
    "yyyy-MM-dd HH:mm:ssXXXXX"
]

private func _makeInFormatter(_ format: String) -> DateFormatter {
    let f = DateFormatter()
    f.locale = Locale(identifier: "en_US_POSIX")
    f.timeZone = TimeZone(secondsFromGMT: 0)
    f.dateFormat = format
    return f
}

public extension Date {
    /// Format as Postgres-friendly RFC3339 (with ms + timezone)
    var postgresTimestamp: String { _pgOut.string(from: self) }

    /// Parse various Postgres/ISO-ish inputs.
    static func fromPostgresTimestamp(_ s: String) -> Date? {
        for fmt in _pgInFormats {
            let f = _makeInFormatter(fmt)
            if let d = f.date(from: s) { return d }
        }
        // Last resort: ISO8601DateFormatter (accepts more variants)
        let iso = ISO8601DateFormatter()
        iso.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let d = iso.date(from: s) { return d }
        iso.formatOptions = [.withInternetDateTime]
        return iso.date(from: s)
    }
}
