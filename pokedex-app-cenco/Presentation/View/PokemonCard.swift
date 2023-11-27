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
    
    @State var pokemonDetails: PokemonDetails?
    @State var pokemonImage: Image?
    @State private var isLoading: Bool = true // Agrega una variable para rastrear la carga
    
    // Estructura para almacenar los detalles del Pokémon
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
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
    
    
//    @ObservedObject var viewModel = PokemonViewModel()
    var body: some View {
        ZStack{
            Color(.black).opacity(0.9).ignoresSafeArea(.all)
            //POKEMON CARD
            ZStack{
                VStack{
                    if isLoading {
                        Rectangle()
                            .fill(Color.gray.opacity(0.1))
                            .frame(width: 150, height: 100)
                            .cornerRadius(10)
                            .overlay(ProgressView())
                    }
                    else{
                    //llamo a la clase pokemon
                        HStack{
                            Text(pokemon.name.capitalized)
                                .bold()
                                .foregroundColor(.white)
                                .font(Font.system(size: 21, weight: .heavy))
                            
                            Spacer()
                            
                                // Mostrar el ID del Pokémon
                                if let id = pokemonDetails?.id {
                                    Text("#\(id)")
                                        .foregroundColor(.white)
                                        .font(Font.system(size: 21, weight: .heavy))
                                        .opacity(0.4)
                                }
                        }


                        
                    HStack{
                        // Mostrar todas las etiquetas de tipo del Pokémon
                        VStack(spacing: 10) {
                            ForEach(pokemonDetails?.types ?? [], id: \.type.name) { typeElement in
                                Text(typeElement.type.name.capitalized)
                                    .font(Font.system(size: 14, weight: .heavy))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).fill(.white.opacity(0.30)))
                                    .cornerRadius(25)
                                    .frame(height: 25)
                            }
                        }
//                        let typeValue = pokemonDetails?.types[0].type.name ?? "default"
//                        Text(typeValue)
//                            .font(Font.system(size:14 , weight: .heavy))
//                            .foregroundColor(.white)
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 8)
//                            .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).fill(.white.opacity(0.30)))
//                            .frame(width: 100, height: 25)
                        
                            // sprites / oficial-artwork / front_default
                            if let image = pokemonImage {
                                image
                                    .resizable()
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
            .shadow(color: Color(backgroundColor(forType: pokemonDetails?.types[0].type.name ?? "default")), radius: 5, x: 0.0, y:0.0)

            ZStack{
                Image("vector")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 80, maxHeight: 80)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.15) // Puedes ajustar la opacidad según tus necesidades
            }
            .zIndex(0)

        }
        .onAppear{
            loadPokemonDetails()
        }
    //el siguiente es el fin del body
    }

}

#Preview {
    PokemonCard(pokemon: Pokemon.samplePokemon) // le paso el sample pokemon con el objeto / instancia de prueba
}



