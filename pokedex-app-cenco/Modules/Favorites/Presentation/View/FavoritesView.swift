//
//  PokemonFavorites.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 27/11/23.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(favoritesManager.favorites, id: \.id) { pokemon in
                        NavigationLink(destination: PokemonDetalle(pokemon: pokemon)) {
                            PokemonCard(pokemon: pokemon)
                            .frame(maxWidth: 200, maxHeight: 300)
                        }
                    }
                }
                .padding(.vertical, 20)
            }
            //cambiar el color de "Mis favoritos"
            .foregroundColor(.white)
            .navigationTitle("Mis favoritos")
            .background(Color(.white)) // Fondo gris oscuro
            .onAppear{
                favoritesManager.loadFavorites()
            }
           
        }
        
    }
}
