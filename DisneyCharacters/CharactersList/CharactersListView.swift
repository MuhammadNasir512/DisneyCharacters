import SwiftUI

struct CharactersListView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            List(viewModel.charactersCellModels) { character in
                NavigationLink(destination: CharacterDetailsView(viewModel: character)) {
                    CharacterItemView(viewModel: character)
                }
            }
            .listStyle(.plain)
            .navigationTitle(viewModel.screenTitle)
            .navigationBarItems(trailing: HStack {
                Button(action: {
                    loadCharactersList()
                }) {
                    Image(systemName: "arrow.clockwise").font(.title2)
                }
                .foregroundColor(.blue)
            })
        }
        .overlay(ProgressView().background(.white).opacity(viewModel.isLoading ? 1 : 0))
        .alert(isPresented: $viewModel.needsShowingErrorAlert) {
            Alert(title: Text(viewModel.error?.localizedDescription ?? "Unknown Error"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: loadCharactersList)
    }
    
    private func loadCharactersList() {
        viewModel.loadCharactersList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let apiHandler = APIHandler()
        let viewModel = CharactersListView.ViewModel(apiHandler: apiHandler)
        CharactersListView(viewModel: viewModel)
    }
}
