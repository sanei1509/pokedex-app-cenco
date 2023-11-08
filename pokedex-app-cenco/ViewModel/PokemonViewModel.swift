//
//  PokemonViewModel.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//

import SwiftUI
import Foundation

class PokemonViewModel:ObservableObject{
    @Published var pokemonDatos: [Pokemon] = []
    let baseUrl = "https://pokeapi.co/api/v2/pokemon?limit=50"
    
    init() {
        fetchPokemon()
    }
    
    func fetchPokemon(){
        guard let url = URL(string: baseUrl) else {return}
        
        URLSession.shared.dataTask(with: url){data,_,_ in
            guard let data = data else { return }
            do{
                let response = try JSONDecoder().decode(PokemonResponse.self, from: data)
                DispatchQueue.main.async {
                    self.pokemonDatos = response.results
                }
                
                //imprimir datos obtenidoss
                for item in response.results{
                    print(item)
                }
            }catch let error as NSError{
                print("Error en la extracción del JSON", error.localizedDescription)
            }
        }.resume()
    }
    
//    func fetchPokemonDetail(pokemon: Pokemon, completion: @escaping (Pokemon) -> Void) {
//        guard let detailURL = URL(string: pokemon.url) else {
//            completion(pokemon)
//            return
//        }
//
//        URLSession.shared.dataTask(with: detailURL) { data, _, error in
//            if let error = error {
//                print("Error en la solicitud de detalles:", error)
//                completion(pokemon)
//                return
//            }
//
//            if let data = data {
//                var updatedPokemon = pokemon // Hacer una copia mutable
//                do {
//                    let pokemonDetail = try JSONDecoder().decode(PokemonDetail.self, from: data)
//                    // Actualizar los detalles del Pokémon
//                    updatedPokemon.details = pokemonDetail
//                    completion(updatedPokemon)
//                } catch let error as NSError {
//                    print("Error al parsear los detalles:", error.localizedDescription)
//                    completion(pokemon)
//                }
//            }
//        }.resume()
//    }

    

    func backgroundColor(forType type:String)-> UIColor{
        switch type{
        case "fire": return .systemRed
        case "poison": return .systemGreen
        case "water": return .systemBlue
        case "electric": return .systemYellow
        case "psychic": return .systemPurple
        case "ground": return .systemGray
        case "normal": return .systemOrange
        case "flying": return .systemBrown
        case "fairy": return .systemPink
        default : return .systemIndigo
        }
    }
    
}
