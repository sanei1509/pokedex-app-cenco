//
//  SwiftUIView.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//
import SwiftUI

struct PokemonCard: View {
    @StateObject var datosJson: PokemonViewModel
    let pokemon : Pokemon
    
    @State private var pokemonDetails: PokemonDetails? 
    
    @State private var pokemonImage: Image?
    // Estructura para almacenar los detalles del Pokémon
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self._datosJson = StateObject(wrappedValue: PokemonViewModel())
        // Llama a la función para cargar los detalles del Pokémon cuando se inicializa la vista
        loadPokemonDetails()
    }
    
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                if let uiImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.pokemonImage = Image(uiImage: uiImage)
                    }
                }
            }
        }.resume()
    }
    
    func loadPokemonDetails() {
//        Task {
//            await datosJson.fetchPokemon()
//        }
        guard let url = URL(string: pokemon.url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let details = try JSONDecoder().decode(PokemonDetails.self, from: data)
                    DispatchQueue.main.async {
                        self.pokemonDetails = details
                        
                        
                        
                        if let imageUrlString = details.sprites.other.filter({ $0.key == "official-artwork" }).map({ $0.value.frontDefault }).first,
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
            
            //POKEMON CARD
            ZStack{
                VStack{
                    
                    //llamo a la clase pokemon
                    Text(pokemon.name.uppercased())
                        .bold().foregroundColor(.white)
                        .font(.headline)
                    HStack{
                        
                        
                        // types / type ./name
                        let typeValue = pokemonDetails?.types[0].type.name ?? "default"
                        Text(typeValue)
                            .font(.caption)
                            .foregroundColor(.white)
                            .bold()
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).fill(.white.opacity(0.25)))
                            .frame(width: 80, height: 25)
                        // sprites / oficial-artwork / front_default
                        if let image = pokemonImage {
                            image
                                .resizable()
                                .frame(width: 80, height: 80)
                                .scaledToFit()
                        }

                    }
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 10)
            .padding(.horizontal, 8)
            .background(Color(backgroundColor(forType: pokemonDetails?.types[0].type.name ?? "default")))
            .cornerRadius(18)
            .shadow(color: Color(backgroundColor(forType: pokemonDetails?.types[0].type.name ?? "default")), radius: 15, x: 0.0, y:0.0)


            .overlay{
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


//struct PokemonCard_preview: PreviewProvider {
//    static var previews: some View{
//        Group {
////            PokemonCard(pokemon: Pokemon())
//            PokemonCard(pokemon: Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/5/"))
//        }.previewLayout(.fixed(width: 200, height: 200))
//    }
//}

#Preview {
    PokemonCard(pokemon: Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/8/"))
}
