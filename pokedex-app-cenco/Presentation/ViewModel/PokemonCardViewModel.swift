//
//  PokemonViewModel.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//

import SwiftUI
import Foundation

class PokemonCardViewModel : ObservableObject {
    @Published var pokemonDetails: PokemonDetails?
    @Published var pokemonImage: Image?
//    @State var pokemonDetails: PokemonDetails?
//    @State var pokemonImage: Image?
    @Published var scrollOffset: CGFloat = 0
    @Published var pokemon: Pokemon
    @Published var isLoading: Bool = true
    
    // Solid
//    private let repository = PokemonRepository()
    
    //constructor
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        loadPokemonDetails()
    }
    
    
    func loadPokemonDetails() {
        isLoading = true // Establece isLoading en true cuando comienza la carga de detalles
        guard let url = URL(string: pokemon.url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let details = try JSONDecoder().decode(PokemonDetails.self, from: data)
                    DispatchQueue.main.async {
                        self.pokemonDetails = details
                        
                        if let imageUrlString = /*details.sprites.front_default*/details.sprites.other.filter({ $0.key == "official-artwork" }).map({ $0.value.frontDefault }).first,
                           let imageUrl = URL(string: imageUrlString) {
                            self.loadImage(from: imageUrl)
                        }
                        //                        print("#NUM --", details.id)
                        print("Successfully decoded Pokemon details")
                    }
                } catch {
                    print("Error decoding Pokémon details: \(error)")
                }
            }
        }.resume()
    }
    
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                if let uiImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.pokemonImage = Image(uiImage: uiImage)
                        self.isLoading = false
                        //                        print("==============")
                        //                        print(Image(uiImage: uiImage))
                        //                        print("Successfully loaded Pokemon image")
                    }
                }
            } else if let error = error {
                print("Error loading image: \(error)")
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
