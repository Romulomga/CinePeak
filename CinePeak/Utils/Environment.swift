import Foundation

enum Environment {
    enum Keys {
        static let apiBaseUrl = "API_BASE_URL"
        static let apiToken = "API_TOKEN"
        static let posterBasePath = "POSTER_BASE_PATH"
        static let backdropBasePath = "BACKDROP_BASE_PATH"

    }
    
    private static let infoDisctionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dict
    }()
    
    static let apiBaseUrl: String = {
        guard let apiKeyString = Environment.infoDisctionary[Keys.apiBaseUrl] as? String else {
            fatalError("API Key not set in plist")
        }
        return apiKeyString
    }()
    
    static let apiToken: String = {
        guard let apiTokenString = Environment.infoDisctionary[Keys.apiToken] as? String else {
            fatalError("API Token not set in plist")
        }
        return apiTokenString
    }()
    
    static let posterBasePath: String = {
        guard let posterBasePathString = Environment.infoDisctionary[Keys.posterBasePath] as? String else {
            fatalError("Post Base Path not set in plist")
        }
        return posterBasePathString
    }()
    
    static let backdropBasePath: String = {
        guard let backdropBasePathString = Environment.infoDisctionary[Keys.backdropBasePath] as? String else {
            fatalError("Backdrop Base Path not set in plist")
        }
        return backdropBasePathString
    }()
}
