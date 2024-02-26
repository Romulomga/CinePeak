import SwiftUI

@main
struct CinePeakApp: App {
    @ObservedObject var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.navigationPath) {
                coordinator.view(for: .moviesList)
                    .preferredColorScheme(.dark)
            }
            .sheet(isPresented: $coordinator.isModalPresented) {
                if let modalDestination = coordinator.modalDestination {
                    coordinator.view(for: modalDestination)
                }
            }
        }
    }
}
