//
//  SwiftUIView.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 5/11/23.
//

import SwiftUI

struct ListadoPokemon: View {
    @StateObject var datosJson = PokemonViewModel()
    private let columnasGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView{
            
            ScrollView{
                LazyVGrid(columns: columnasGrid, spacing: 20.0){
                    //Listado de datos
                    if datosJson.pokemonDatos.isEmpty {
                        ProgressView()
                    }else{
                        ForEach(datosJson.pokemonDatos, id: \.id){pokemon in
                            
                            PokemonCard(pokemon: pokemon)
                                .frame(height: 100)
                            
                        }
                    }
                }
            }
            .navigationTitle("") // Elimina el título predeterminado
            .navigationBarBackButtonHidden(true) // Elimina la flecha hacia atrás predeterminada
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .toolbar {
                // Modifica el diseño del navigationTitle y agrega espacio en blanco
                ToolbarItem(placement: .topBarLeading) {
                    VStack {
                            Image(systemName: "arrow.backward")
                                .font(.title)
                                .imageScale(.small) // Cambia el tamaño de la flecha
                                .foregroundColor(.black) // Cambia el color de la flecha
                                .padding(.top, 30)
                                .padding(.bottom, 5)
                                .padding(.trailing, 70 )
                        Text("Pokedex")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black) // Cambia el color del título
                            .padding(.bottom, 10) // Agrega espacio en blanco hacia arriba y hacia abajo
                    }
                }
                ToolbarItem(placement: .principal) {
                    Spacer()
                }
                
            }

        }
    }
    
}

#Preview {
    ListadoPokemon()
}
