//
//  PokemonDetail.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//

import SwiftUI


// DETALLEEEEEEE

struct PokemonDetalle: View {
    @StateObject var datosJson = PokemonViewModel()
    
    let pokemon : Pokemon
    @State var pokemonDetails: PokemonDetails?
    @State var pokemonImage: Image?
    @State private var isLoading: Bool = true // Agrega una variable para rastrear la carga
    @State private var isFavorite = false
    
    let pokemonId: Int
    private let favoritesManager = FavoritesManager()
    
    // Estructura para almacenar los detalles del Pokémon
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.pokemonId = pokemon.id ?? 0
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
                        //                        print("HABILIDADES --", details.abilities)
                        //                        print("EXPERIENCIA --", details.baseExperience)
                        //                        print("", details.height)
                        //                        print(details.weight)
                        //                        print("TIPOS=========", details.types)
                        //                        print("SPRITES=========", details.sprites)
                        print("Successfully decoded Pokemon details")
                    }
                } catch {
                    print("Error decoding Pokémon details: \(error)")
                }
            }
        }.resume()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.green).ignoresSafeArea()
                Color(backgroundColor(forType: pokemonDetails?.types.first?.type.name ?? "default")).ignoresSafeArea()
                ScrollView{
                    VStack(alignment: .leading) {
                        // Encabezado con nombre, tipo y corazón
                        HStack {
                            VStack(alignment: .leading) {
                                Text(pokemon.name.capitalized).font(Font.system(size: 40, weight: .heavy)).foregroundColor(.white)
                                
//                                VStack(spacing: 10) {
//                                    ForEach(pokemonDetails?.types ?? [], id: \.type.name) { typeElement in
//                                        Text(typeElement.type.name.capitalized)
//                                            .font(Font.system(size: 14, weight: .heavy))
//                                            .foregroundColor(.white)
//                                            .padding(.horizontal, 16)
//                                            .padding(.vertical, 8)
//                                            .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).fill(.white.opacity(0.30)))
//                                            .cornerRadius(25)
//                                            .frame(height: 25)
//                                    }
//                                }

                            }
                            .padding(.leading, 30)
                            .padding(.top, -40)
                            Spacer() // Separa el texto y el corazón
                            Button(action: toggleFavorite){
                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(isFavorite ? .red : .white)
                                    .font(.title)
//                                    .foregroundColor(.white)
                                    .padding(.trailing, 30)
                                    .padding(.bottom, 30)
                            }.onAppear {
                                isFavorite = favoritesManager.isFavorite(pokemonId: pokemonId)
                            }

                        }
                    }
                    VStack{ // imagen del pokemon : idea dejar de respaldo una imagen sombra pokemon misterioso
                        if let image = pokemonImage {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 400)
                        } else {
                            Image("1") // Imagen de reserva
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 400)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .zIndex(1)
                    .padding(.bottom, -150)
                    //zona blanca de la descripcion
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.vertical, 8)
                            .foregroundColor(.black)
                        Text("texto random de description sobre este maravilloso personaje")
                            .lineSpacing(8.0)
                            .opacity(0.6)
                            .foregroundColor(.black)
                        
                        // Espacio de SIZE
                        VStack(alignment: .center){
                            HStack{
                                HStack(spacing: 10) {
                                    ForEach(pokemonDetails?.types ?? [], id: \.type.name) { typeElement in
                                        Text(typeElement.type.name.capitalized)
                                            .font(Font.system(size: 14, weight: .heavy))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(backgroundColor(forType: typeElement.type.name))
                                            .cornerRadius(25)
                                            .frame(height: 25)
                                    }
                                }
                            }
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                            
                            
                            Text("Size")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            HStack{
                                VStack{
                                    Text("Height: ")
                                        .opacity(0.6)
                                        .padding(20)
                                        .foregroundColor(.black)
                                    Text("\(pokemonDetails?.height ?? 0) M")
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                }
                                Spacer()
                                
                                VStack{
                                    Text("Weight: ")
                                        .foregroundColor(.black)
                                        .opacity(0.6)
                                        .padding(20)
                                    Text("\(pokemonDetails?.weight ?? 0) Kg").fontWeight(.heavy)
                                        .foregroundColor(.black)
                                }

                                    
                            }
                        }
                        .padding(.top, 10)
                        
                    
                        HStack (alignment: .center) {
                            Spacer()
                            VStack {
                                VStack (alignment: .center) {
                                    Text("Base Stats")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                    Text("Base experience:  \(pokemonDetails?.base_experience ?? 0)")
                                        .foregroundColor(.black)
                                    
                                }.padding(10)
                                VStack (alignment: .center) {
                                    Text("Others")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
 
                                    Text("Abilities: Bola de fuego")
                                        .opacity(0.6)
                                        .foregroundColor(.black)
                                    //                            .frame(maxWidth: .infinity, alignment: .leading).ignoresSafeArea()
                                }.padding(10)
                            }
                            Spacer()
                        }
                        .padding(.vertical)
                    }
                    .padding(.bottom, 80)
                    .padding()
                    .padding(.top, 280)
                    .background(.white)
                    .offset(x: 0, y: -250)
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                }
            }.onAppear{
                loadPokemonDetails()
            }
            
            
        }
    }
    // function toggle to use in the heart to create whishlist
    private func toggleFavorite() {
        isFavorite.toggle()
        if isFavorite {
            favoritesManager.addFavorite(pokemonId: pokemonId)
        } else {
            favoritesManager.removeFavorite(pokemonId: pokemonId)
        }
    }
    
}


struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

