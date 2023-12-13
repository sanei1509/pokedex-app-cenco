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
    @EnvironmentObject private var favoritesManager: FavoritesManager
    
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
            favoritesManager.addFavorite(pokemon: viewModel.pokemon)
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
            .padding(.top, 5)
            .padding(.bottom, 10)
            
            VStack{
                HStack{
                    Spacer()
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
                    Spacer()
                        
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
                        Text("Stats")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        //Barras de estadisticas
                        VStack{

                            HStack {
                                Text("EXP")
                                    .foregroundColor(.black)
                                    .frame(width: 50)
                                
                                Rectangle()
                                    .fill(Color.yellow)
                                    .frame(width: barWidth(for: viewModel.pokemonDetails?.base_experience ?? 0, max: 300), height: 10)
                                    .cornerRadius(10)
                                   
                                Spacer()

                                Text("\(viewModel.pokemonDetails?.base_experience ?? 0)/\(300)")
                                    .font(.caption)
                            }
                            
                            HStack {
                                Text("HP")
                                    .foregroundColor(.black)
                                    .frame(width: 50)
                                Rectangle()
                                    .fill(Color.red)
                                    .frame(width: barWidth(for: viewModel.pokemonDetails?.base_experience ?? 0, max: 300), height: 10)
                                    .cornerRadius(10)
                                Spacer()
                                Text("100\(300)")
                                    .font(.caption)
                            }
                            
                            HStack {
                                Text("ATK")
                                    .foregroundColor(.black)
                                    .frame(width: 50)
                                Rectangle()
                                    .fill(Color.purple)
                                    .frame(width: barWidth(for: viewModel.pokemonDetails?.base_experience ?? 0, max: 300 ), height: 10)
                                    .cornerRadius(10)
                                Spacer()
                                Text("100\(300)")
                                    .font(.caption)
                            }
                            
                            HStack {
                                Text("DEF")
                                    .foregroundColor(.black)
                                    .frame(width: 50)
                                Rectangle()
                                    .fill(Color.brown)
                                    .frame(width: barWidth(for: viewModel.pokemonDetails?.base_experience ?? 0, max: 300), height: 10)
                                    .cornerRadius(10)
                                Spacer()
                                Text("100\(300)")
                                    .font(.caption)
                            }
                        }
                        
                    }.padding(10)
                    VStack (alignment: .center) {
                        Text("Abilities")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)

                        VStack{
//                            Text("Abilities: ")
//                                .opacity(0.6)
//                                .foregroundColor(.black)
                            
                            Text("Bola de fuego")
                                .foregroundColor(.black)
                        }

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
    
    private func barWidth(for value: Int, max maxValue: Int) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width - 40 // Ajustar según el padding deseado
        let fraction = CGFloat(value) / CGFloat(maxValue )
        return fraction * screenWidth
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

