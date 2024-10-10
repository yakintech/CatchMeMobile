//
//  GameHomeScreen.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 12.08.2024.
//

import SwiftUI

struct Game: Identifiable {
    let id = UUID()
    let name: String
    let game: AnyView
}

struct GameHomeScreen: View {
    @State private var games: [Game] = [
        Game(name: "Color Match", game: AnyView(ColorMatchGameScreen())),
        Game(name: "Color Mind", game: AnyView(ColorMindScreen()))
    ]
    
    var body: some View {
        NavigationView {
                    List(games) { game in
                        NavigationLink(destination: game.game) {
                            Text(game.name)
                        }
                    }
                    .navigationTitle("Games")
                }
    }
}

#Preview {
    GameHomeScreen()
}
