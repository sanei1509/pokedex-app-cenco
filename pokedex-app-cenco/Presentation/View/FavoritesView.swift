//
//  PokemonFavorites.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 27/11/23.
//

import SwiftUI

struct FavoritesView: View {
//    @ObservedObject var favoritesManager: FavoritesManager
    
    var body: some View {
        NavigationView {
            List {
                Text("1")
                Text("2")
                Text("3")
            }
            .navigationTitle("Mis favoritos")
            .foregroundColor(.black)
        }
    }
}
    

#Preview {
    FavoritesView()
}
