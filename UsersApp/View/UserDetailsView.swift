//
//  UserDetailsView.swift
//  UsersApp
//
//  Created by Kesh Gurung on 10/05/2023.
//

import SwiftUI

struct UserDetailsView: View {
    let user: User
    var body: some View {
        VStack( alignment: .leading){
            userInfo.padding()
            Spacer()
        }
    }
    
    var userInfo: some View {
        VStack(alignment: .leading){
            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 300)
            .background(Color.gray)
            .padding()
            Text("Name: \(user.name ?? "NA")")
                .bold()
            Text("Twitter: \(user.twitterUsername ?? "NA")")
                .bold()
            Text("Company: \(user.company ?? "NA")")
                .bold()
            Text("Email: \(user.email ?? "NA")")
                .bold()
        }
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(user: User.mockUser())
    }
}
