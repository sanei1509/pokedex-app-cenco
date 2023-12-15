//
//  ContentView.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 3/11/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var favoritesManager = FavoritesManager()

//    init() {
//        // Configuración de apariencia principal
//        UITabBar.appearance().barTintColor = UIColor.black
//        UITabBar.appearance().tintColor = UIColor.white
//        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
//    }

    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }.environmentObject(favoritesManager)
            
            FavoritesView()
                .tabItem {
                    Label("Favoritos", systemImage: "star")
                }.environmentObject(favoritesManager)
        }
        // un color distino al fondo del pokemons para que se pueda ver siempre sin ser blanco porque si es blanco no se ve
        .accentColor(Color(.black))
        
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    MainView()
}
