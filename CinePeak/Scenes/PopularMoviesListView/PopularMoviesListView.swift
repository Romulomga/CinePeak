import SwiftUI
import NetworkKit

struct PopularMoviesListView<ViewModel: ObservableObject & PopularMoviesListViewModelProtocol>: View {
    let coordinator: AppCoordinator
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    //etupContent()
                }
                .listStyle(.plain)
                .background(Color.background)
            }
            .navigationTitle("Popular")
            .navigationBarTitleDisplayMode(.automatic)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    PopularMoviesListView(
        coordinator: AppCoordinator(),
        viewModel: PopularMoviesListViewModel()
    )
}
