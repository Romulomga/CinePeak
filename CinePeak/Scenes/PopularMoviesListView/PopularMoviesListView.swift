import SwiftUI
import Kingfisher

struct PopularMoviesListView<ViewModel: ObservableObject & PopularMoviesListViewModelProtocol>: View {
    let coordinator: AppCoordinator
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color
                    .background
                    .ignoresSafeArea()
                
                switch viewModel.viewState {
                    case .loading:
                        LoadingView()
                    case .loaded:
                        ListView(viewModel: viewModel)
                    case .empty:
                        EmptyView(retryAction: viewModel.refresh)
                    case .error(let errorMessage):
                        ErrorView(errorMessage: errorMessage, retryAction: viewModel.refresh)
                }
            }
            .background(Color.background)
            .navigationTitle("Popular")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
    
    struct ListView: View {
        @StateObject var viewModel: ViewModel
        @State private var scales = [Int: CGFloat]()
        
        var body: some View {
            let columns: [GridItem] = [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(viewModel.items) { movie in
                        VStack {
                            KFImage(movie.posterPath)
                                .placeholder({
                                    ProgressView().scaleEffect(2.0).tint(Color.onBackground)
                                })
                                .fade(duration: 0.25)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10.0)
                                .scaleEffect(scales[movie.id, default: 1.0])
                                .onTapGesture {
                                    withAnimation(.easeIn(duration: 0.25)) {
                                        scales[movie.id] = 0.8
                                    }
                                    withAnimation(.easeOut(duration: 0.25).delay(0.1)) {
                                        scales[movie.id] = 1.0
                                    }
                                }
                                .onAppear() {
                                    viewModel.loadMoreContent(currentItem: movie)
                                }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .refreshable {
                viewModel.refresh()
            }
        }
    }
    
    struct LoadingView: View {
        var body: some View {
            ProgressView()
                .scaleEffect(2.0)
                .tint(Color.onBackground)
        }
    }
    
    struct EmptyView: View {
        let retryAction: () -> Void
        
        var body: some View {
            VStack(spacing: 16) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color.onBackground)
                Text("No Results Found")
                    .font(.title)
                    .foregroundColor(Color.onBackground)
                Text("We couldn't find what you were looking for. Try checking your internet connection.")
                    .font(.body)
                    .foregroundColor(Color.onBackground)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                Button(action: retryAction) {
                    Text("Try Again")
                        .bold()
                        .font(.body)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(Color.onAccent)
                        .cornerRadius(10)
                }
            }
        }
    }
    
    struct ErrorView: View {
        var errorMessage: String
        let retryAction: () -> Void
        
        var body: some View {
            VStack(spacing: 16) {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.red)
                Text("An error occurred while loading the data.")
                    .fontWeight(.semibold)
                    .font(.body)
                    .foregroundColor(Color.onBackground)
                Button(action: retryAction) {
                    Text("Try Again")
                        .bold()
                        .font(.body)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(Color.onAccent)
                        .cornerRadius(10)
                }
            }
        }
    }
}
