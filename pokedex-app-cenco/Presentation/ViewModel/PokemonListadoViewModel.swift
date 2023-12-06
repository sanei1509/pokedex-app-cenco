//
//  PokemonCardViewModel.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 28/11/23.
//

import Foundation

class PokemonListadoViewModel: ObservableObject {
    @Published var pokemonDatos: [Pokemon] = []
    private let repository = PokemonRepository()
    
    init(){
        fetchPokemon()
    }
    
    func fetchPokemon(){
        repository.fetchPokemon { pokemonDatos in
            self.pokemonDatos = pokemonDatos
        }
    }
}
