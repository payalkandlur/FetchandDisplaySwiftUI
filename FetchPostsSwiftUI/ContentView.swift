//
//  ContentView.swift
//  FetchPostsSwiftUI
//
//  Created by Payal Kandlur on 10/16/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errMsg = viewModel.errMessage {
                    Text("Error: , \(errMsg)")
                } else {
                    List(viewModel.user) { i in
                        VStack(alignment: .leading) {
                            HStack(alignment: .center) {
                                Text("Name: ")
                                Text("\(i.firstName)")
                                    .foregroundColor(.gray)
                            }
                            
                            HStack(alignment: .center) {
                                Text("Email: ")
                                Text("\(i.email)")
                                    .foregroundColor(.gray)
                                    .padding(.top)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("User")
        .task {
            await viewModel.fetchUser()
        }
    }
}

#Preview {
    ContentView()
}
