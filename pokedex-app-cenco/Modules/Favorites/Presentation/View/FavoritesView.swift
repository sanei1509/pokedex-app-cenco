//
//  PokemonFavorites.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 27/11/23.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager

    
    var body: some View {
        NavigationView {
            List(favoritesManager.favorites, id: \.self) { pokemonId in
                Text("Pokemon ID: \(pokemonId)")
                    .foregroundColor(.black)
                    .font(.title)
            }
            .navigationTitle("Mis favoritos")
            .foregroundColor(.black)
            .onAppear{
                favoritesManager.loadFavorites()
            }
        }
    }
}
