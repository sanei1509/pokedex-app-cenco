//
//  Pokemon.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//




import Foundation
import SwiftUI

struct PokemonList: Decodable {
    let results: [Pokemon]
}

struct PokemonResponse: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Codable {
    var name: String
    var url: String
    var id: Int? {
        return Int(url.split(separator: "/").last?.description ?? "0")
    }
    
//    var imageUrl: URL? {
//        if let id = self.id {
//            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
//        }
//        return nil
//    }
    
}


//let PokemonList:[Pokemon2] = [
//    .init(id: 1, name: "Ivysaur", imageUrl: "", type: "poison", description: "", height: 5, weight: 5),
//    .init(id: 2, name: "Pikachu", imageUrl: "", type: "electric", description: "", height: 3, weight: 10),
//    .init(id: 3, name: "Squirtle", imageUrl: "", type: "water", description: "", height: 5, weight: 5),
//    .init(id: 4, name: "Charmander", imageUrl: "", type: "fire", description: "", height: 10, weight: 15),
//    .init(id: 5, name: "Ivysaur", imageUrl: "", type: "psychic", description: "", height: 5, weight: 5),
//    .init(id: 6, name: "Pikachu", imageUrl: "", type: "fairy", description: "", height: 3, weight: 10),
//    .init(id: 7, name: "Squirtle", imageUrl: "", type: "normal", description: "", height: 5, weight: 5),
//    .init(id: 8, name: "Charmander", imageUrl: "", type: "flying", description: "", height: 10, weight: 15)
//]


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


//class PokeApi {
//    //vamos a traer una colección de pokemones
//    func getData(completion: @escaping ([PokemonEntry]) -> ()){
//        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=50") else {return}
//            
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { return }
//            // Crear una instancia de JSONDecoder
//            let decoder = JSONDecoder()
//
//            do {
//                // Llamar al método 'decode' en la instancia de JSONDecoder
//                let pokemonList = try decoder.decode(Pokemon.self, from: data)
//                
//                DispatchQueue.main.async {
//                    completion(pokemonList.results)
//                }
//            } catch {
//                // Maneja errores de decodificación aquí
//                print("Error al decodificar JSON: \(error)")
//            }
//            
//            
//
//        }.resume()
//    }
//}


//final class PokemonApi {
//    
//    func loadPokemon(completion: @escaping (Result<[Pokemon], Error>) -> ())  {
//        
//        AF.request("https://pokeapi.co/api/v2/pokemon?limit=151").responseDecodable(of: PokemonList.self) { response in
//            
//            switch response.result {
//            case .success(let pokemonList):
//                completion(.success(pokemonList.results))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//    
//}
