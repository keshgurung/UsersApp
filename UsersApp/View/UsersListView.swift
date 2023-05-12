//
//  UsersListView.swift
//  UsersApp
//
//  Created by Kesh Gurung on 09/05/2023.
//

import SwiftUI

struct UsersListView: View {
    @StateObject var viewModel: UserViewModel
    @State private var isErrorOccured = true
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView()
                case .loaded:
                    showUsersListView()
                case .error:
                    showErrorView()
                case .emptyView:
                    EmptyView()
                }
            }
            .navigationTitle(Text(LocalizedStringKey("Users")))
        }
        .refreshable {
            await viewModel.getUsersList(path: RestApiEndPoints.usersPath)
        }
        .task {
            if viewModel.viewState != .error {
                await viewModel.getUsersList(path: RestApiEndPoints.usersPath)
                isErrorOccured = false
            }
            
        }
    }
    
    @ViewBuilder
    func showUsersListView() -> some View {
        List(viewModel.users){ user in
            NavigationLink {
                UserDetailsView(user: user)
            }label: {
                UserView(user: user)
            }
        }
    }
    
    @ViewBuilder
    func showErrorView() -> some View {
        VStack {
            Text("Some Thing went wrong pls try again!")
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView(viewModel: UserViewModel())
    }
}
