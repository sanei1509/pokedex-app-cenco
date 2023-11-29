//
//  File.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 23/11/23.
//

import Foundation
import SwiftUI






class PokemonRepository {
    
    
    func fetchPokemonDetails(for pokemonURL: String, completion: @escaping (PokemonDetails?) -> Void) {
        guard let url = URL(string: pokemonURL) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let details = try JSONDecoder().decode(PokemonDetails.self, from: data)
                completion(details)
            } catch {
                print("Error decoding Pokémon details: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    
    func fetchImage(from urlString: String, completion: @escaping (Image?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            if let uiImage = UIImage(data: data) {
                let image = Image(uiImage: uiImage)
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }

    
//    func fetchPokemonDetails(for pokemon: Pokemon, completion: @escaping (PokemonDetails?) -> Void) {
//        // Lógica para cargar detalles del Pokémon
//    }
//
//    func fetchImage(for url: URL, completion: @escaping (Image?) -> Void) {
//        // Lógica para cargar la imagen del Pokémon
//    }
}
