//
//  CategoriesScreen.swift
//  CatchMe
//
//  Created by Arda Nar on 3.09.2024.
//

import SwiftUI
import Alamofire

struct CategoriesScreen: View {
    
    @State var categories: [Categorie] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    if categories.indices.contains(0) {
                        Button(action: {
                            print(categories[0].name)
                        }) {
                            Text(categories[0].name)
                                .frame(width: 130)
                                .padding()
                                .background(Color.cyan)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    if categories.indices.contains(1) {
                        Button(action: {
                            print(categories[1].name)
                        }) {
                            Text(categories[1].name)
                                .frame(width: 130)
                                .padding()
                                .background(Color.cyan)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                
                HStack(spacing: 20) {
                    if categories.indices.contains(2) {
                        Button(action: {
                            print(categories[2].name)
                        }) {
                            Text(categories[2].name)
                                .frame(width: 130)
                                .padding()
                                .background(Color.cyan)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    if categories.indices.contains(3) {
                        Button(action: {
                            print(categories[3].name)
                        }) {
                            Text(categories[3].name)
                                .frame(width: 130)
                                .padding()
                                .background(Color.cyan)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                
                if categories.indices.contains(4) {
                    Button(action: {
                        print(categories[4].name)
                    }) {
                        Text(categories[4].name)
                            .frame(width: 130)
                            .padding()
                            .background(Color.cyan)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .onAppear {
                fetchCategories()
            }
        }
    }
    
    func fetchCategories() {
        let url = "https://goldfish-app-zjg23.ondigitalocean.app/categories"
        
        AF.request(url).responseDecodable(of: [Categorie].self) { response in
            switch response.result {
            case .success(let categories):
                self.categories = categories
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    CategoriesScreen()
}
