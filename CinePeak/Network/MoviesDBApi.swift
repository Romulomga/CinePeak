import Foundation
import NetworkKit

enum MoviesDBApi {
    case getPopularMovies(page: Int)
}

extension MoviesDBApi: EndPointType {
    var baseURL: URL {
        URL(string: Environment.apiBaseUrl)!
    }

    var version: String {
        switch self {
        case .getPopularMovies:
            return "3"
        }
    }
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return "/movie/popular"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getPopularMovies:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .getPopularMovies(let page):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                bodyEncoding: .urlEncoding,
                                                urlParameters: ["language": "en-US", "page": "\(page)"],
                                                additionHeaders: headers)
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .getPopularMovies:
            return [
                "Authorization": "Bearer \(Environment.apiToken)"
            ]
        }
    }
}
