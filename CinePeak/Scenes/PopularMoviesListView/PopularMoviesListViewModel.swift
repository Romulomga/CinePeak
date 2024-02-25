import Foundation

protocol PopularMoviesListViewModelProtocol: ObservableObject {
    var items: [Movie] { get set }
    var viewState: LoadingState { get set }
    var moviesRepository: MoviesRepositoryProtocol { get set }
    
    func loadItems() async
    func loadMoreContent(currentItem movie: Movie)
    func refresh()
}

final class PopularMoviesListViewModel: PopularMoviesListViewModelProtocol {
    @Published var viewState: LoadingState = .loading
    
    var items: [Movie] = []
    var moviesRepository: MoviesRepositoryProtocol
    private var page = 1
    private var totalPages = 0

    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
        
        Task {
            await loadItems()
        }
    }
    
    @MainActor
    func loadItems() async {
        let response = await moviesRepository.loadPopularMovies(page: page)
        
        switch response {
            case .success(let response):
                guard !response.results.isEmpty else {
                    viewState = .empty
                    return
                }
                
                totalPages = response.totalPages
                for item in response.results {
                    if !items.contains(where: { $0.id == item.id }) {
                        items.append(item)
                    }
                }
                page += 1
                viewState = .loaded
                
            case .failure(let error):
                viewState = .error(error.localizedDescription)
        }
    }
    
    func loadMoreContent(currentItem movie: Movie) {
        guard viewState != .loading else { return }
        let thresholdIndex = items.index(items.endIndex, offsetBy: -1)
        let itemIndex = items.firstIndex(of: movie)

        if thresholdIndex == itemIndex, page <= totalPages {
            page += 1
            Task {
                await loadItems()
            }
        }
    }
    
    func refresh() {
        page = 1
        items = []
        Task {
            await loadItems()
        }
    }
}
