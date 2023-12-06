//
//  File.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 23/11/23.
//

import Foundation
import SwiftUI

class PokemonRepository {
//    func fetchPokemonDetails(for pokemon: Pokemon, completion: @escaping (PokemonDetails?) -> Void) {
//        // Lógica para cargar detalles del Pokémon
//    }
//
//    func fetchImage(for url: URL, completion: @escaping (Image?) -> Void) {
//        // Lógica para cargar la imagen del Pokémon
//    }
    func fetchPokemon(completion: @escaping ([Pokemon]) -> Void) {
        let baseUrl = "https://pokeapi.co/api/v2/pokemon?limit=100"
        guard let url = URL(string: baseUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(PokemonResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.results)
                }
            } catch {
                print("Error en la extracción del JSON", error.localizedDescription)
            }
        }.resume()
    }
    
}
