//
//  UsersAppApp.swift
//  UsersApp
//
//  Created by Kesh Gurung on 09/05/2023.
//

import SwiftUI

@main
struct UsersAppApp: App {
    let dataController = DataController.shared

    var body: some Scene {
        WindowGroup {
            UsersListView(viewModel: UserViewModel()).environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
