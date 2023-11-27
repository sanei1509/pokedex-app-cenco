//
//  FavoritesManager.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 27/11/23.
//

import Foundation

class FavoritesManager: ObservableObject {
    @Published var favorites: [Int] = []

    func addFavorite(pokemonId: Int) {
        if !favorites.contains(pokemonId) {
            favorites.append(pokemonId)
        }
    }

    func removeFavorite(pokemonId: Int) {
        favorites.removeAll { $0 == pokemonId }
    }
    
    func isFavorite(pokemonId: Int) -> Bool {
        return favorites.contains(pokemonId)
    }
}
