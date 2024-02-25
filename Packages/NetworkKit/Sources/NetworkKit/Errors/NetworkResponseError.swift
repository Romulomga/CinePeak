import Foundation

public enum NetworkResponseError: Error {
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
    case httpURLResponseCastFailed
    
    public var localizedDescription: String {
        switch self {
        case .authenticationError: return String(localized: "You need to be authenticated first.", bundle: .module)
        case .badRequest: return String(localized: "Bad request.", bundle: .module)
        case .outdated: return String(localized: "The url you requested is outdated.", bundle: .module)
        case .failed: return String(localized: "Network request failed.", bundle: .module)
        case .noData: return String(localized: "Response returned with no data to decode.", bundle: .module)
        case .unableToDecode: return String(localized: "We could not decode the response.", bundle: .module)
        case .httpURLResponseCastFailed: return String(localized: "HTTP url response cast failed.", bundle: .module)
        }
    }
}
