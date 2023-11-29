//
//  PokemonDetail.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//

import SwiftUI

// DETALLEEEEEEE
struct PokemonDetalle: View {
    @ObservedObject var viewModel: PokemonCardViewModel
    @State private var isFavorite = false
    
    private let pokemonId: Int
    private let favoritesManager = FavoritesManager()
    
    // Estructura para almacenar los detalles del Pokémon
    init(pokemon: Pokemon) {
        self.pokemonId = pokemon.id ?? 0
        self.viewModel = PokemonCardViewModel(pokemon: pokemon)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(backgroundColor(forType: viewModel.pokemonDetails?.types.first?.type.name ?? "default")).ignoresSafeArea()
                ScrollView{
                    // Encabezado con nombre, tipo y corazón
                    headerDetailView
                    imageOfPokemonDetailView
                    //AREA / SECCION BLANCA POKEMON
                    detailPokemonWhiteView
                }
            }.onAppear{
                viewModel.loadPokemonDetails()
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
    
    private var sizeView: some View {
        VStack(alignment: .center){
            HStack{
                HStack(spacing: 10) {
                    ForEach(viewModel.pokemonDetails?.types ?? [], id: \.type.name) { typeElement in
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
                    Text("\(viewModel.pokemonDetails?.height ?? 0) M")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }
                Spacer()
                
                VStack{
                    Text("Weight: ")
                        .foregroundColor(.black)
                        .opacity(0.6)
                        .padding(20)
                    Text("\(viewModel.pokemonDetails?.weight ?? 0) Kg").fontWeight(.heavy)
                        .foregroundColor(.black)
                }

                    
            }
        }
        .padding(.top, 10)
        
    }
    
    private var headerDetailView: some View{
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.pokemon.name.capitalized).font(Font.system(size: 40, weight: .heavy)).foregroundColor(.white)
                    
                }
                .padding(.leading, 30)
                .padding(.top, 0)
                Spacer() // Separa el texto y el corazón
                Button(action: toggleFavorite){
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .white)
                        .font(.title)
                    //                                    .foregroundColor(.white)
                        .padding(.trailing, 30)
                        .padding(.bottom, -10)
                }.onAppear {
                    isFavorite = favoritesManager.isFavorite(pokemonId: pokemonId)
                }
                
            }
        }
    }
    
    private var imageOfPokemonDetailView: some View {
        VStack { // imagen del pokemon : idea dejar de respaldo una imagen sombra pokemon misterioso
            if let image = viewModel.pokemonImage {
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
    }
    
    private var detailPokemonWhiteView: some View {
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
            sizeView
        
            HStack (alignment: .center) {
                Spacer()
                VStack {
                    VStack (alignment: .center) {
                        Text("Base Stats")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Text("Base experience:  \(viewModel.pokemonDetails?.base_experience ?? 0)")
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
    
    // ============
}

//Codigo para poder dar un redondeado
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

