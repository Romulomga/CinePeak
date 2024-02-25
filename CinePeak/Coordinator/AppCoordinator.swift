import Foundation
import SwiftUI

final class AppCoordinator {
    private let dependencies: DependencyContainer

    init(dependencies: DependencyContainer = DependencyContainer()) {
        self.dependencies = dependencies
    }

    func start() -> some View {
        let viewModel = PopularMoviesListViewModel(moviesRepository: dependencies.moviesRepository)
        return PopularMoviesListView(coordinator: self, viewModel: viewModel)
    }

//    func navigateToDetailView(for item: Item) -> some View {
//        DetailView(item: item)
//    }
}
