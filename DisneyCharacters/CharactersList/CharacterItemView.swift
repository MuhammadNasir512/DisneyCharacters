import SwiftUI

struct CharacterItemView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Image(uiImage: viewModel.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50, alignment: .center)
                .background(Color.black)
                .clipped()
                .overlay(ProgressView().background(.clear).opacity(viewModel.isLoading ? 1 : 0))
            Text(viewModel.name).dynamicTypeSize(.small)
            Spacer()
        }
    }
    
    private enum Constant {
        static let addDeleteButtonPadding: CGFloat = 7
    }
}

struct CharacterItemView_Previews: PreviewProvider {
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
        CharacterItemView(viewModel: viewModel)
    }
}
