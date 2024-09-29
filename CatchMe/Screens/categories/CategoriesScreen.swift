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
                
                ForEach(0 ..< categories.count / 2, id: \.self) { index in
                    HStack(spacing: 20) {
                        
                        // Sol buton
                        Button(action: {
                            print(categories[index * 2].name)
                        }, label: {
                            Text(categories[index * 2].name)
                                .frame(width: 130)
                                .padding()
                                .background(Color.cyan)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        })
                        
                        // Sağ buton
                        if index * 2 + 1 < categories.count {
                            Button(action: {
                                print(categories[index * 2 + 1].name)
                            }, label: {
                                Text(categories[index * 2 + 1].name)
                                    .frame(width: 130)
                                    .padding()
                                    .background(Color.cyan)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            })
                        }
                    }
                }
                
                // Son eleman tek ise en alt ortada yerleştime
                // Eğer yeni bir eleman gelirse bu kod çalışmayacak
                if categories.count % 2 != 0 {
                    Button(action: {
                        print(categories.last?.name ?? "No Category")
                    }, label: {
                        Text(categories.last?.name ?? "")
                            .frame(width: 130)
                            .padding()
                            .background(Color.cyan)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    })
                    .frame(width: 130, alignment: .center)
                }
                
            }
            .padding()
            .onAppear {
                fetchCategories()
            }
        }
    }
    
    func fetchCategories() {
        let url = "\(APIConfig.baseURL)/categories"
        
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
