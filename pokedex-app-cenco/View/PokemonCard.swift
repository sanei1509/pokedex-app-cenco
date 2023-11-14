//
//  SwiftUIView.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//
import SwiftUI

struct PokemonCard: View {
    @StateObject var datosJson = PokemonViewModel()
    let pokemon : Pokemon
    
    @State private var pokemonDetails: PokemonDetails? 
    
    @State private var pokemonImage: Image?
    
    @State private var isLoading: Bool = false // Agrega una variable para rastrear la carga
   
    // Estructura para almacenar los detalles del Pokémon
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        // Llama a la función para cargar los detalles del Pokémon cuando se inicializa la vista
        loadPokemonDetails()
    }
    
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                if let uiImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.pokemonImage = Image(uiImage: uiImage)
                        self.isLoading = false
                    }
                }
            }
        }.resume()
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
                        
                        
                        if let imageUrlString = details.sprites.front_default,
                           let imageUrl = URL(string: imageUrlString) {
                            self.loadImage(from: imageUrl)
                        }
                        print(details)
//                        print("TIPOS=========", details.types)
//                        print("SPRITES=========", details.sprites)
                    }
                } catch {
                    print("Error decoding Pokémon details: \(error)")
                }
            }
        }.resume()
    }
    
    
//    @ObservedObject var viewModel = PokemonViewModel()
    var body: some View {
        ZStack{
            Color(.white).ignoresSafeArea(.all)
            
            // Mostrar el ProgressView mientras isLoading es true
            if isLoading {
                ProgressView()
            }
            //POKEMON CARD
            ZStack{
                VStack{
                    //llamo a la clase pokemon
                    Text(pokemon.name.capitalized)
                        .bold()
                        .foregroundColor(.white)
                        .font(Font.system(size: 21, weight: .heavy))

                    HStack{
                        // types / type ./name
                        let typeValue = pokemonDetails?.types[0].type.name ?? "default"
                        Text(typeValue)
                            .font(Font.system(size:14 , weight: .heavy))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).fill(.white.opacity(0.30)))
                            .frame(width: 80, height: 25)
       
                        if !isLoading{
                            // sprites / oficial-artwork / front_default
                            if let image = pokemonImage {
                                image
                                    .frame(width: 80, height: 80)
                            }
                            
                        }
                    }
                }
                
            }
            .padding(.top, 8)
            .padding(.bottom, 10)
            .padding(.horizontal, 8)
            .background(Color(backgroundColor(forType: pokemonDetails?.types[0].type.name ?? "default")))
            .cornerRadius(18)
            .shadow(color: Color(backgroundColor(forType: pokemonDetails?.types[0].type.name ?? "default")), radius: 12, x: 0.0, y:0.0)

            ZStack{
                Image("vector")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 80, maxHeight: 80)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.2) // Puedes ajustar la opacidad según tus necesidades
                    
                    
            }

        }
        .onAppear(){
            loadPokemonDetails()
        }
    //el siguiente es el fin del body
    }

}

#Preview {
    PokemonCard(pokemon: Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/2/"))
}
