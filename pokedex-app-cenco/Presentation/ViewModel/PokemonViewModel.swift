//
//  PokemonViewModel.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//

import SwiftUI
import Foundation

class PokemonViewModel:ObservableObject{
    //ultioms
    @Published var pokemonDetails: PokemonDetails?
    @Published var pokemonImage: Image?
    @Published var scrollOffset: CGFloat = 0
    @Published var pokemonDatos: [Pokemon] = []
    
    let baseUrl = "https://pokeapi.co/api/v2/pokemon?limit=50"
    
    // Solid
    private let repository = PokemonRepository()
    
    func loadPokemonData(pokemonURL: String) {
        repository.fetchPokemonDetails(for: pokemonURL) { [weak self] details in
            DispatchQueue.main.async {
                self?.pokemonDetails = details
                if let imageUrlString = details?.sprites.other["official-artwork"]?.frontDefault {
                    self?.loadImage(from: imageUrlString)
                }
            }
        }
    }
    
    private func loadImage(from urlString: String) {
        repository.fetchImage(from: urlString) { [weak self] image in
            DispatchQueue.main.async {
                self?.pokemonImage = image
            }
        }
    }
    
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
                
//                for item in response.results{
//                    print(item)
//                }
            }catch let error as NSError{
                print("Error en la extracción del JSON", error.localizedDescription)
            }
        }.resume()
    }
    
//    func loadPokemonData(pokemon: Pokemon) {
//        repository.fetchPokemonDetails(for: pokemon) { details in
//            DispatchQueue.main.async {
//                self.pokemonDetails = details
//                // Cargar la imagen si es necesario
//                if let imageUrlString = details?.sprites.other["official-artwork"]?.frontDefault,
//                   let imageUrl = URL(string: imageUrlString) {
//                    self.repository.fetchImage(for: imageUrl) { image in
//                        DispatchQueue.main.async {
//                            self.pokemonImage = image
//                        }
//                    }
//                }
//            }
//        }
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
