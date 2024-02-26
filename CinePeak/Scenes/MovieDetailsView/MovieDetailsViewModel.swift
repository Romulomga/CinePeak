import Foundation

protocol MovieDetailsViewModelProtocol: ObservableObject {
    var movie: Movie { get set }
    var viewState: LoadingState { get set }
}

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    @Published var viewState: LoadingState = .loading
    
    var movie: Movie
    
    init(item: Movie) {
        self.movie = item
    }
}
