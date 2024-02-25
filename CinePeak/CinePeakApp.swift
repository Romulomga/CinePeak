import SwiftUI

@main
struct CinePeakApp: App {
    var body: some Scene {
        WindowGroup {
            let coordinator = AppCoordinator()
            coordinator.start()
                .preferredColorScheme(.dark)
        }
    }
}
