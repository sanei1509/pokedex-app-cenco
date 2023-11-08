//
//  PokeAPi.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 7/11/23.
//

import SwiftUI


class PokemonViewModel2: ObservableObject{
    @Published var datosPokemon: [PokemonModel] = []
    
    //constructor
    init(){
        fetchData()
    }
    
    func fetchData(){
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=50") else {return}
        
        URLSession.shared.dataTask(with: url){data,_,_ in
            guard let data = data else { return }
            do{
                let json = try JSONDecoder().decode([PokemonModel].self, from: data)
                DispatchQueue.main.async {
                    self.datosPokemon = json
                }
            }catch let error as NSError{
                print("Error en la extracción del JSON", error.localizedDescription)
            }
        }.resume()
    }
}

struct PokemonModel: Decodable{
    var name: String
    var ImageUrl: String
    var types: [String]
}
