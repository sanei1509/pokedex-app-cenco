//
//  PokemonViewModel.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//

import SwiftUI
import Foundation

class PokemonViewModel:ObservableObject{
    @Published var pokemon = [Pokemon]()
    let baseUrl = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0"
    init() {
        fetchPokemon()
    }
    func fetchPokemon(){
        guard let url = URL(string: baseUrl) else {return}
        
        URLSession.shared.dataTask(with: url){(data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }
            
            guard let pokemon = try? JSONDecoder().decode([Pokemon].self, from: data) else {return}
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        }.resume()
    }

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
extension Data {
    func parseData(removeString string:String) -> Data?{
        let dataString = String(data:self, encoding: .utf8)
        let parsedDataString = dataString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else {
            return nil
        }
        return data
    
    }
}
