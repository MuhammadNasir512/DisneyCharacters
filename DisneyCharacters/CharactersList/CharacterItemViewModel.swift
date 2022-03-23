import SwiftUI
import PromiseKit

extension CharacterItemView {
    
    final class ViewModel: ObservableObject, Identifiable {
        @Published var isLoading = false
        @Published var image = UIImage()
        private let apiHandler: APIHandlerType

        let id: Int
        let name: String
        let films: [String]
        let tvShows: [String]
        let videoGames: [String]
        let imageUrlString: String
        
        let nameTitle = "Name:"
        let filmsTitle = "Films:"
        let tvShowsTitle = "TV Shows:"
        let videoGamesTitle = "Video Games:"

        init(charactersModel: CharactersModel, apiHandler: APIHandlerType) {
            self.apiHandler = apiHandler
            id = charactersModel.id
            name = charactersModel.name
            films = charactersModel.films
            tvShows = charactersModel.tvShows
            videoGames = charactersModel.videoGames
            imageUrlString = charactersModel.imageUrl
            if let image = UIImage(named: "Placeholder") {
                self.image = image
            }

            isLoading = true
            firstly {
                apiHandler.getImage(urlString: imageUrlString)
            }.ensure { [weak self] in
                self?.isLoading = false
            }.done { [weak self] data in
                guard let self = self, let image = UIImage(data: data) else { return }
                self.image = image
            }.catch { _ in }
        }
    }
}
