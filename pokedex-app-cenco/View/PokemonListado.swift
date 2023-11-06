//
//  SwiftUIView.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 5/11/23.
//

import SwiftUI

struct ListadoPokemon: View {
    private let columnasGrid = [GridItem(.flexible()), GridItem(.flexible())]
//    let pokemon = Pokemon()
    //    @ObservedObject var viewModel = PokemonViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: columnasGrid, spacing: 20.0){
                    ForEach(PokemonList){ pokemon in
                        PokemonCard(pokemon: pokemon)
                    }
                    
                }
            }.navigationTitle("Listado")
        }
    }
}

#Preview {
    ListadoPokemon()
}
