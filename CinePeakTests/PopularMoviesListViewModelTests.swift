import XCTest
import NetworkKit

final class PopularMoviesListViewModelTests: XCTestCase {
    
    var repository: MockMoviesRepository!
    var sut: PopularMoviesListViewModel!
    
    override func setUp() {
        super.setUp()
        repository = MockMoviesRepository()
        sut = PopularMoviesListViewModel(moviesRepository: repository)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLoadItemsSuccess() async {
        let mockRepository = MockMoviesRepository()
        mockRepository.mockMoviesResponse = PaginatedResponse(page: 1, results: [Movie(id: 0, originalLanguage: "", overview: "", title: "", voteAverage: 1.0)], totalPages: 1, totalResults: 1)
        let viewModel = PopularMoviesListViewModel(moviesRepository: mockRepository)
        
        await viewModel.loadItems()
        
        XCTAssertEqual(viewModel.items.count, 1)
        XCTAssertEqual(viewModel.viewState, .loaded)
    }
    
    func testLoadItemsEmpty() async {
        let mockRepository = MockMoviesRepository()
        mockRepository.mockMoviesResponse = PaginatedResponse(page: 1, results: [], totalPages: 1, totalResults: 1)
        let viewModel = PopularMoviesListViewModel(moviesRepository: mockRepository)
        
        await viewModel.loadItems()
        
        XCTAssertEqual(viewModel.items.count, 0)
        XCTAssertEqual(viewModel.viewState, .empty)
    }
    
    func testLoadItemsError() async {
        let mockRepository = MockMoviesRepository()
        mockRepository.shouldReturnError = true
        let viewModel = PopularMoviesListViewModel(moviesRepository: mockRepository)
        
        await viewModel.loadItems()
        
        XCTAssertEqual(viewModel.items.count, 0)
        XCTAssertEqual(viewModel.viewState, .error("A operação não pôde ser concluída. ( erro -1.)"))
    }
}
