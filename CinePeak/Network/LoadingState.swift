import Foundation

enum LoadingState: Equatable {
    case loading
    case loaded
    case empty
    case error(String)
}
