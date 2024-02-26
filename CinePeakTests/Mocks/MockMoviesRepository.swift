import Foundation
import NetworkKit

final class MockMoviesRepository: MoviesRepositoryProtocol {
    var shouldReturnError = false
    var mockMoviesResponse: PaginatedResponse<Movie>?

    func loadPopularMovies(page: Int) async -> Result<PaginatedResponse<Movie>, Error> {
        if shouldReturnError {
            return .failure(NSError(domain: "", code: -1, userInfo: nil))
        } else {
            return .success(mockMoviesResponse ?? PaginatedResponse(page: 1, results: [], totalPages: 1, totalResults: 1))
        }
    }
}
