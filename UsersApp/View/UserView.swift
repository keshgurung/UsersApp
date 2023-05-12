//
//  UserView.swift
//  UsersApp
//
//  Created by Kesh Gurung on 10/05/2023.
//

import SwiftUI

struct UserView: View {
    let user: User
    var body: some View {
        CacheAsyncImage(url: URL(string: user.avatarUrl )!){ phase in
            switch phase {
            case .success(let image):
                HStack(spacing: 10) {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 44, height: 44)
                        .background(Color.gray)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Name: \(user.name ?? "NA")")
                            .font(.body)
                        Text("Email: \(user.email ?? "NA")")
                            .font(.body)
                    }
                    Spacer()
                }
            case .failure:
                HStack(spacing: 10) {
                    Image(systemName: "questionmark")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 44, height: 44)
                        .background(Color.gray)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Name: \(user.name ?? "NA")")
                            .font(.body)
                        Text("Email: \(user.email ?? "NA")")
                            .font(.body)
                    }
                    Spacer()
                }
            case .empty:
                HStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .red))
                    Spacer()
                }
            @unknown default:
                Image(systemName: "questionmark")
            }
            
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User.mockUser())
    }
}
