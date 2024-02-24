import Foundation

public enum NetworkError: Error {
    case parametersNil
    case serializationError
    case missingURL
    
    var localizedDescription: String {
        switch self {
            case .parametersNil: return String(localized: "Parameters were nil.", bundle: .module)
            case .serializationError: return String(localized: "Parameter serialization failed.", bundle: .module)
            case .missingURL: return String(localized: "URL is nil.", bundle: .module)
        }
    }
}
