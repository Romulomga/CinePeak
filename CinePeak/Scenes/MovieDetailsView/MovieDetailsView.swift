import Foundation
import SwiftUI
import Kingfisher

struct MovieDetailsView<ViewModel: ObservableObject & MovieDetailsViewModelProtocol>: View {
    let coordinator: AppCoordinator
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            GeometryReader(content: { geometry in
                KFImage(viewModel.movie.backdropPath)
                    .placeholder({
                        ProgressView().scaleEffect(2.0).tint(Color.onBackground)
                    })
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            })
            
            VStack {
                Spacer()
                ZStack {
                    Rectangle()
                        .fill(.clear)
                        .frame(maxHeight: 500)
                        .overlay(.ultraThinMaterial)
                        .blur(radius: 8)
                        .offset(y: 80)
                    
                    VStack(spacing: 16) {
                        Text(viewModel.movie.title)
                            .fontWeight(.semibold)
                            .font(.title)
                            .foregroundColor(Color.onBackground)
                        Text(viewModel.movie.overview)
                            .font(.callout)
                            .foregroundColor(Color.onBackground)
                            .multilineTextAlignment(.center)
                            .lineLimit(8)
                            .truncationMode(.tail)
                        
                        HStack(spacing: 8) {
                            Button(action: {
                                
                            }) {
                                HStack {
                                    Image(systemName: "play.fill")
                                    Text("WATCH MOVIE")
                                        .fontWeight(.semibold)
                                }
                                .font(.body)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 16)
                                .background(Color.accentColor)
                                .foregroundColor(.onAccent)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            //.frame(maxWidth: .infinity)

                            Button(action: {
                                
                            }) {
                                Text("TRAILER")
                                    .fontWeight(.semibold)
                                    .font(.body)
                                    .padding(.vertical, 16)
                                    .padding(.horizontal, 16)
                                    .background(Color.background.opacity(0.2))
                                    .foregroundColor(.onBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        
                        HStack(spacing: 4) {
                            Text("\(viewModel.movie.originalLanguage.uppercased())• ")
                            Text("\(viewModel.movie.formatterYear() ?? "")")
                            Text("🍅")
                            Text("\(String(format: "%0.1f", viewModel.movie.voteAverage))")

                        }
                        .fontWeight(.semibold)
                        .font(.callout)
                        .foregroundColor(.onBackground)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .ignoresSafeArea(edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
    }
}
