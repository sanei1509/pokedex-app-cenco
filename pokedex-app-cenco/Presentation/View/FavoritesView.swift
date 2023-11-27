//
//  PokemonFavorites.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 27/11/23.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoritesManager: FavoritesManager
    
    var body: some View {
        NavigationView {
            List(Array(favoritesManager.favorites), id: \.self){ pokemonId in
                Text("Pokemon ID: \(pokemonId)")
                    .foregroundColor(.black)
            }
            .navigationTitle("Mis favoritos")
            .foregroundColor(.black)
        }
    }
}
    

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(favoritesManager: FavoritesManager())
    }
}
