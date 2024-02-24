import Foundation

public protocol EndPointType {
    var baseURL: URL { get }
    var version: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders { get }
}
