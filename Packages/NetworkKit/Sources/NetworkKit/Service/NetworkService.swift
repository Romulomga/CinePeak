import Foundation

public typealias ResultWithError<Model> = Result<Model, Error>
public typealias NetworkServiceCompletion<Model: Codable> = (ResultWithError<Model>) -> Void

public protocol NetworkServiceProtocol: AnyObject {
    associatedtype EndPoint: EndPointType
    
    func request<Model: Decodable>(ofType: Model.Type, _ route: EndPoint, completion: @escaping NetworkServiceCompletion<Model>)
    func request<Model: Decodable>(ofType: Model.Type, _ route: EndPoint) async throws -> ResultWithError<Model>
}

private extension NetworkServiceProtocol {
    
    func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(
            url: route.baseURL.appendingPathComponent(route.version).appendingPathComponent(route.path),
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0
        )
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
                case .request:
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                case .requestParameters(let bodyParameters, let bodyEncoding, let urlParameters):
                    try configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding, urlParameters: urlParameters, request: &request)
                case .requestParametersAndHeaders(let bodyParameters, let bodyEncoding, let urlParameters, let additionalHeaders):
                    addAdditionalHeaders(additionalHeaders, request: &request)
                    try configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding, urlParameters: urlParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    func configureParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?, request: inout URLRequest) throws {
        try bodyEncoding.encode(urlRequest: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
    }
    
    func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

public final class NetworkService<EndPoint: EndPointType>: NetworkServiceProtocol {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<Model: Decodable>(ofType: Model.Type, _ route: EndPoint, completion: @escaping NetworkServiceCompletion<Model>) {
        
        do {
            let request = try buildRequest(from: route)
            let task = session.dataTask(with: request) { data, response, error in
                let mappedResponse: ResultWithError<Model> = ResponseHandler.handle(data, response, error)
                DispatchQueue.main.async {
                    completion(mappedResponse)
                }
            }
            
            task.resume()
            
        } catch {
            completion(.failure(error))
        }
    }
    
    public func request<Model: Decodable>(ofType: Model.Type, _ route: EndPoint) async throws -> ResultWithError<Model> {
        do {
            let request = try buildRequest(from: route)
            let (data, response) = try await session.data(for: request)
            let mappedResponse: ResultWithError<Model> = ResponseHandler.handle(data, response)
            
            return mappedResponse
            
        } catch {
            return .failure(error)
        }
    }
}

