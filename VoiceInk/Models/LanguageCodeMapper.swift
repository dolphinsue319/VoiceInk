import Foundation

enum LanguageCodeMapper {
    /// Maps extended language codes to API-compatible codes.
    /// e.g. "zh-Hans" → "zh", "zh-Hant" → "zh"
    static func apiLanguageCode(_ code: String) -> String {
        switch code {
        case "zh-Hans", "zh-Hant": return "zh"
        default: return code
        }
    }

    /// Maps legacy language codes to their modern equivalents.
    /// e.g. "zh" → "zh-Hans" (default to Simplified for existing users)
    static func modernLanguageCode(_ code: String) -> String {
        switch code {
        case "zh": return "zh-Hans"
        default: return code
        }
    }
}
