import SwiftUI
import NetworkKit

struct PopularMoviesListView<ViewModel: ObservableObject & PopularMoviesListViewModelProtocol>: View {
    let coordinator: AppCoordinator
    @StateObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, World! \(Environment.apiBaseUrl)")

                Button("aeee") {

                    NetworkService<MoviesDBApi>().request(ofType: PaginatedResponse<Movie>.self, .getPopularMovies(page: 1)) { result in
                        
                        switch result {
                            case .success(let movies):
                                break
                                
                            case .failure:
                                break
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Main")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PopularMoviesListView(coordinator: AppCoordinator(), viewModel: PopularMoviesListViewModel())
}
