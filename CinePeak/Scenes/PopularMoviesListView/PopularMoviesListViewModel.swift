import Foundation

protocol PopularMoviesListViewModelProtocol: ObservableObject {
    var items: [Movie] { get set }
    var isLoading: Bool { get set }
    func loadItems()
}

final class PopularMoviesListViewModel: PopularMoviesListViewModelProtocol {
    @Published var items: [Movie] = []
    @Published var isLoading = false

    // Simulando uma chamada de API assíncrona
    func loadItems() {
        self.isLoading = true
        // Aqui você faria a chamada para sua API
        // Por agora, vamos simular um delay e depois carregar dados mockados
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.items = []
            self.isLoading = false
        }
    }
}
