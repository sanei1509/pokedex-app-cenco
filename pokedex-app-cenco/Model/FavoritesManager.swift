//
//  FavoritesManager.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 27/11/23.
//

import Foundation

class FavoritesManager: ObservableObject {
    @Published var favorites: [Pokemon] = [] {
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
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }

    func loadFavorites() {
        if let savedFavorites = UserDefaults.standard.data(forKey: favoritesKey) {
            if let decodedFavorites = try? JSONDecoder().decode([Pokemon].self, from: savedFavorites) {
                self.favorites = decodedFavorites
            }
        }
    }
    
    // User default code end here
    // Vamos a agregar a favoritos instancias de pokemon
    func addFavorite(pokemon: Pokemon) {
        if !favorites.contains(where: { $0.id == pokemon.id }) {
            favorites.append(pokemon)
        }
        saveFavorites()
    }

    func removeFavorite(pokemonId: Int) {
        favorites.removeAll { $0.id == pokemonId }
        saveFavorites()
    }
    
    func isFavorite(pokemonId: Int) -> Bool {
        return favorites.contains(where: { $0.id == pokemonId })
    }
}
