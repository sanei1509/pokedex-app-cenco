//
//  ContentView.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 3/11/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var favoritesManager = FavoritesManager()
    
    
    init() {
        // Establece el color de los ítems del tab no seleccionados
        UITabBar.appearance().unselectedItemTintColor = UIColor.white

        // Establece el color de fondo del TabBar si es necesario
        UITabBar.appearance().backgroundColor = UIColor.black
    }
    
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
        .accentColor(.yellow)
        .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MainView()
}
