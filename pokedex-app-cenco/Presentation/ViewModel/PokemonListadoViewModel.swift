//
//  PokemonCardViewModel.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 28/11/23.
//

import Foundation

class PokemonListadoViewModel: ObservableObject {
    @Published var pokemonDatos: [Pokemon] = []
    let baseUrl = "https://pokeapi.co/api/v2/pokemon?limit=50"
    
    init(){
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
}
