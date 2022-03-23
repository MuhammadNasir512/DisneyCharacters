//
//  DisneyCharactersApp.swift
//  DisneyCharacters
//
//  Created by Muhammad Nasir Ali on 23/03/2022.
//

import SwiftUI

@main
struct DisneyCharactersApp: App {
    var body: some Scene {
        WindowGroup {
            let apiHandler = APIHandler()
            let viewModel = CharactersListView.ViewModel(apiHandler: apiHandler)
            CharactersListView(viewModel: viewModel)
        }
    }
}
