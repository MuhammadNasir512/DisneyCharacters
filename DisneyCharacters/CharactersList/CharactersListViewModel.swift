import PromiseKit

extension CharactersListView {
    
    final class ViewModel: ObservableObject {
        
        @Published var charactersCellModels = [CharacterItemView.ViewModel]()
        @Published var isLoading = false
        @Published var needsShowingErrorAlert = false
        @Published private(set) var error: Error? = nil
        let screenTitle = "Disney Characters" // Move to Localizable.strings
        private var nextPageUrlString = ""
        private var totalPages = 0
        
        private var apiHandler: APIHandlerType
        init(apiHandler: APIHandlerType) {
            self.apiHandler = apiHandler
        }
        
        func loadCharactersList() {
            charactersCellModels.removeAll()
            continueLoading()
        }
        
        func loadNextPage() {
            apiHandler.urlString = nextPageUrlString
            continueLoading()
        }
        
        private func continueLoading() {
            isLoading = true
            firstly {
                apiHandler.getData()
            }.ensure { [weak self] in
                self?.isLoading = false
            }.done { [weak self] data in
                self?.handleSuccess(data: data)
            }.catch { [weak self] error in
                self?.handleError(error: error)
            }
        }
        
        private func handleSuccess(data: Data) {
            do {
                let decoder = JSONDecoder()
                let rootObject = try decoder.decode(RootObject.self, from: data)
                let characters = rootObject.data
                charactersCellModels += characters.map { CharacterItemView.ViewModel(charactersModel: $0, apiHandler: apiHandler) }
                nextPageUrlString = rootObject.nextPage
                totalPages = rootObject.totalPages
            } catch let error as NSError {
                handleError(error: error)
            }
        }
        
        private func handleError(error: Error) {
            self.error = error
            needsShowingErrorAlert = true
        }
    }
}
