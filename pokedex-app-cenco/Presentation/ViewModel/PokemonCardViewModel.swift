//
//  PokemonViewModel.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//

import SwiftUI
import Foundation

class PokemonCardViewModel : ObservableObject {
    var descriptionPokemon: String = ""
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
    
    func savePokemon() {
        
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
                        self.loadPokemonSpeciesDetails()
                        
                        if let imageUrlString = /*details.sprites.front_default*/details.sprites.other.filter({ $0.key == "official-artwork" }).map({ $0.value.frontDefault }).first,
                           let imageUrl = URL(string: imageUrlString) {
                            self.loadImage(from: imageUrl)
                        }
                        print("DETALLE ---->",details)
                        //                        print("#NUM --", details.id)
                        print("Successfully decoded Pokemon details")
                    }
                } catch {
                    print("Error decoding Pokémon details: \(error)")
                }
            }
        }.resume()
    }
    
    
    func loadPokemonSpeciesDetails() {
        guard let speciesURL = pokemonDetails?.species.url else { return }

        guard let url = URL(string: speciesURL) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let species = try JSONDecoder().decode(PokemonSpeciesDetails.self, from: data)
                    DispatchQueue.main.async {
                        // Procesar flavorText aquí
                        if let englishFlavorText = species.flavorTextEntries.first {
                            print("Flavor text: \(englishFlavorText.flavorText)")
                            self.descriptionPokemon = englishFlavorText.flavorText
                        }
                        
                    }
                } catch {
                    print("Error decoding Pokémon species details: \(error)")
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
    
}
