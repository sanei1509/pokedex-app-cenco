//
//  FavoritesManager.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 27/11/23.
//

import Foundation

class FavoritesManager: ObservableObject {
    @Published var favorites: [Int] = [] {
        //cada vez que se actualiza el array de favoritos, se guarda en UserDefaults
        didSet {
            saveFavorites()
        }
    }
    
    private let favoritesKey = "favorites"

    init() {
        loadFavorites()
    }

    private func saveFavorites() {
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
    }

    func loadFavorites() {
        if let savedFavorites = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] {
            self.favorites = savedFavorites
        }
    }
    
    // User default code end here
    
    func addFavorite(pokemonId: Int) {
        if !favorites.contains(pokemonId) {
            favorites.append(pokemonId)
        }
        saveFavorites()
    }

    func removeFavorite(pokemonId: Int) {
        favorites.removeAll { $0 == pokemonId }
        saveFavorites()
    }
    
    func isFavorite(pokemonId: Int) -> Bool {
        return favorites.contains(pokemonId)
    }
}
