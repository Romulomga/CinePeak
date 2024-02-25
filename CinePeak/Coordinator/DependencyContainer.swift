import Foundation
import NetworkKit

final class DependencyContainer {
    private(set) lazy var moviesRepository: MoviesRepositoryProtocol = MoviesRepository(service: NetworkService<MoviesDBApi>())
}
