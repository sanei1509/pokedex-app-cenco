//
//  PokemonDetail.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//

import SwiftUI


// DETALLEEEEEEE

struct PokemonDetalle: View {

    var pokemon: Pokemon
    var pokemonImage: Image?
    var pokemonDetails: PokemonDetails?
    
    var body: some View {
        NavigationView{
            ZStack {
                Color(.green).ignoresSafeArea()
//                Color(backgroundColor(forType: pokemonDetails?.types.first?.type.name ?? "default")).ignoresSafeArea()
                ScrollView{
                    VStack(alignment: .leading) {
                        // Encabezado con nombre, tipo y corazón
                        HStack {
                            VStack(alignment: .leading) {
                                Text(pokemon.name.capitalized).font(Font.system(size: 40, weight: .heavy)).foregroundColor(.white)
                                Text(pokemonDetails?.types[0].type.name ?? "default")
                                    .font(Font.system(size:14 , weight: .heavy))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .overlay(RoundedRectangle(cornerRadius: 25).fill(Color.white.opacity(0.30)))
                                    .frame(width: 80, height: 25)
                            }.padding(.leading, 30)

                            Spacer() // Separa el texto y el corazón

                            Image(systemName: "heart")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.trailing, 30)
                                .padding(.bottom, 30)
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
                            Text("texo random de description sobre este maravilloso pokemon")
                                .lineSpacing(8.0)
                                .opacity(0.6)
        
                            HStack (alignment: .top) {
                                VStack (alignment: .leading) {
                                    Text("Size")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                    Text("Height: 100 cm")
                                        .opacity(0.6)
                                    Text("Weight: 200 kg")
                                        .opacity(0.6)
                                    Text("type: Fire")
                                        .opacity(0.6)
                                    Text("Abilities: Bola de fuego")
                                        .opacity(0.6)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading).ignoresSafeArea()

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
            }
            
            
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

// FINAL DE DETALLE


//#Preview {
//    PokemonDetalle(pokemon: PokemonList[0])
//}
