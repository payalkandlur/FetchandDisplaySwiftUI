//
//  UserViewModel.swift
//  FetchPostsSwiftUI
//
//  Created by Payal Kandlur on 10/16/24.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var user: [User] = []
    @Published var errMessage: String?
    
    private let apiService: ApiService
    
    init(apiService: ApiService = NetworkService()) {
        self.apiService = apiService
    }
    
    func fetchUser() async  {
        do {
            let users = try await apiService.fetch(Users.self)
            user = users.users
        } catch {
            errMessage =  "Failed to fetch posts: \(error.localizedDescription)"
        }
    }
}
