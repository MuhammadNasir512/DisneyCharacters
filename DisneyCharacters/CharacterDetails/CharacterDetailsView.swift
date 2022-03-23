import SwiftUI

struct CharacterDetailsView: View {
    @StateObject var viewModel: CharacterItemView.ViewModel
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Image(uiImage: viewModel.image)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 200, alignment: .center)
                    .background(Color.black)
                    .clipped()
                if let name = viewModel.name {
                    Text("\(viewModel.nameTitle)\n\(name)").padding()
                }
                if let text = filmsText() {
                    Text(text).padding()
                }
                if let text = tvShowsText() {
                    Text(text).padding()
                }
                if let text = videoGamesText() {
                    Text(text).padding()
                }
                Spacer()
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .navigationTitle(viewModel.name ?? "")
    }
    
    private func filmsText() -> String? {
        guard let films = viewModel.films, !films.isEmpty else { return nil }
        return "\(viewModel.filmsTitle)\n" + films.joined(separator: ", ")
    }
    
    private func tvShowsText() -> String? {
        guard let tvShows = viewModel.tvShows, !tvShows.isEmpty else { return nil }
        return "\(viewModel.tvShowsTitle)\n" + tvShows.joined(separator: ", ")
    }
    
    private func videoGamesText() -> String? {
        guard let videoGames = viewModel.videoGames, !videoGames.isEmpty else { return nil }
        return "\(viewModel.videoGamesTitle)\n" + videoGames.joined(separator: ", ")
    }
}

struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let films = ["Film 1", "Film 2"]
        let tvShows = ["TV Show 1", "TV Show 2"]
        let videoGames = ["Game 1", "Game 2"]
        let character = CharactersModel(
            id: 12,
            name: "Disney Item",
            films: films,
            tvShows: tvShows,
            videoGames: videoGames,
            imageUrl: ""
        )
        let apiHandler = APIHandler()
        let viewModel = CharacterItemView.ViewModel(charactersModel: character, apiHandler: apiHandler)
        CharacterDetailsView(viewModel: viewModel)
    }
}
