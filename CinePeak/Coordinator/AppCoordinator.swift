import Foundation
import SwiftUI

final class AppCoordinator: ObservableObject {
    
    enum Destination: Codable, Hashable {
        case moviesList
        case movieDetailsView(movie: Movie)
    }
    
    @Published var navigationPath = NavigationPath()
    @Published var isModalPresented = false
    var modalDestination: Destination?
    private let dependencies: DependencyContainer
    
    init(dependencies: DependencyContainer = DependencyContainer(), navigationPath: NavigationPath = NavigationPath()) {
        self.dependencies = dependencies
        self.navigationPath = navigationPath
    }
    
    func navigate(to destination: Destination, asModal: Bool = false) {
        if asModal {
            modalDestination = destination
            isModalPresented = true
        } else {
            navigationPath.append(destination)
        }
    }
    
    func navigateBack() {
        navigationPath.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    func dismissModal() {
        isModalPresented = false
        modalDestination = nil
    }
    
    @ViewBuilder
    func view(for destination: Destination) -> some View {
        switch destination {
            case .moviesList:
                let viewModel = PopularMoviesListViewModel(moviesRepository: dependencies.moviesRepository)
                PopularMoviesListView(coordinator: self, viewModel: viewModel)
                
            case .movieDetailsView(let movie):
                let viewModel = MovieDetailsViewModel(item: movie)
                MovieDetailsView(coordinator: self, viewModel: viewModel)
        }
    }
}
