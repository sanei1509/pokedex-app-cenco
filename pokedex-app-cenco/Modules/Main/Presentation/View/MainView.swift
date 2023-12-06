//
//  ContentView.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 3/11/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var favoritesManager = FavoritesManager()
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }.environmentObject(favoritesManager)
            
            FavoritesView()
                .tabItem {
                    Label("Favoritos", systemImage: "star")
                }.environmentObject(favoritesManager)
        }
        
    }
}

#Preview {
    MainView()
}
