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
                GeometryReader { geometry in
                    ScrollView {
                        // Encabezado con nombre, tipo y corazón
                        headerDetailView
                        imageOfPokemonDetailView
                        //AREA / SECCION BLANCA POKEMON
                        detailPokemonWhiteView
                    }
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
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? .white : .white)
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
            Text(format(flavorText: viewModel.descriptionPokemon))
                .lineSpacing(8.0)
                .opacity(0.6)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center) // Asegura que el texto ocupe el ancho completo//            Text("\(viewModel.pokemonDetails?.species.url ?? "Es un pokemon y ya")")
//                .lineSpacing(8.0)
//                .opacity(0.6)
//                .foregroundColor(.black)
            // Espacio de SIZE
            sizeView
            
            //Barras de estadisticas
            VStack(alignment: .leading) {
                Text("Stats / Skills ")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
            }
            .padding(.top, 30)
            HStack (alignment: .center) {
                
                Spacer()
                VStack {
                    VStack (alignment: .center) {
                        VStack {
                            VStack(alignment: .leading) {
                                Text("EXP".capitalized)
                                    .fontWeight(.bold)
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                HStack {
                                    Rectangle()
                                        .fill(Color.yellow)
                                        .frame(width: barWidth(for: viewModel.pokemonDetails?.base_experience ?? 0, max: 500), height: 10)
                                        .cornerRadius(10)
                                    
                                    Spacer()
                                    
                                    Text("\(viewModel.pokemonDetails?.base_experience ?? 0)/\(500)")
                                        .font(.system(size: 12))
                                        .fontWeight(.bold)
                                        .font(.caption)
                                        .foregroundColor(.black)
                                }
                            }.padding(.horizontal, 10)
                            
                            if let estadisticas = viewModel.pokemonDetails?.stats{
                                // ForEach para recorrer las estadisticas y mostrarlas
                                ForEach(estadisticas, id: \.stat.name){stat in
                                    
                                    VStack{
                                        Text(stat.stat.name.capitalized(with: nil))
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .font(.system(size: 12))
                                            .foregroundColor(.black)
                                        //lo que ocupe la palabra
                                            .frame(maxWidth: .infinity)
                                        HStack {
                                            Rectangle()
                                                .fill(Color.yellow)
                                                .frame(width: barWidth(for: stat.base_stat, max: 150), height: 10)
                                                .cornerRadius(10)
                                            Spacer()
                                            Text("\(stat.base_stat)/\(100)")
                                                .font(.system(size: 12))
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                        }
                                    }.padding(.horizontal, 10)
                    
                                }
                            }
                        }
                    }.padding(10)
                }

                Spacer()
            }
            .padding(.bottom, 20)
            //Listado de habilidades / abilities
            
            VStack(alignment: .leading) {
                Text("Abilities")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
            }
            HStack (alignment: .center) {
                Spacer()
 

                //Barras de Abilities
                VStack (alignment: .center) {
                    VStack{
                        // Comprueba si hay habilidades disponibles y luego las lista todas
                        if let abilities = viewModel.pokemonDetails?.abilities {
                            ForEach(abilities, id: \.ability.name) { ability in
                                Text(ability.ability.name.capitalized)
                                    .foregroundColor(.black)
                                
                            }
                        } else {
                            // En caso de que no haya habilidades, muestra un texto predeterminado
                            Text("Sin habilidad")
                                .foregroundColor(.black)
                        }
                    }

                }.padding(20)
                
                Spacer()
            }.padding(.vertical, 20)
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
        let fraction = CGFloat(value) / CGFloat(maxValue)
        return fraction * screenWidth
    }
    // ============
    
    private func format(flavorText: String) -> String {
        let formattedString = flavorText
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\u{0C}", with: " ") // Reemplaza \f (salto de formulario)
            .replacingOccurrences(of: "\r", with: " ")
        return formattedString
    }
    
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

