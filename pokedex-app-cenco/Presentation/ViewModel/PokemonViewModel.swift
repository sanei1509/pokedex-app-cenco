//
//  PokemonViewModel.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//

import SwiftUI
import Foundation

class PokemonViewModel:ObservableObject{
    @Published var scrollOffset: CGFloat = 0
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
                
//                for item in response.results{
//                    print(item)
//                }
            }catch let error as NSError{
                print("Error en la extracción del JSON", error.localizedDescription)
            }
        }.resume()
    }
    
//    func fetchPokemonDetail() {
//        guard let datos = self.fetchPokemon() else { return }
//        
//        for item in datos.results{
//            print(item)
//        }
//
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
