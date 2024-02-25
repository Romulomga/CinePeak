import Foundation
import NetworkKit

protocol MoviesRepositoryProtocol {
    func loadPopularMovies(page: Int) async -> Result<PaginatedResponse<Movie>, Error>
}

final class MoviesRepository: MoviesRepositoryProtocol {

    let service: NetworkService<MoviesDBApi>
    
    init(service: NetworkService<MoviesDBApi>) {
        self.service = service
    }

    func loadPopularMovies(page: Int) async -> Result<PaginatedResponse<Movie>, Error> {
        do {
            let response = try await service.request(ofType: PaginatedResponse<Movie>.self, .getPopularMovies(page: page))
            switch response {
                case .success(let response):
                    return .success(response)
                    
                case .failure(let error):
                    return .failure(error)
            }
        } catch {
            return .failure(error)
        }
    }
}
