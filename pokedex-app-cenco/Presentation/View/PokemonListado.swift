//
//  SwiftUIView.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 5/11/23.
//

import SwiftUI

struct PokemonListado: View {
    @StateObject var datosJson = PokemonViewModel()
    private let columnasGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView{
            
            ScrollView{
                LazyVGrid(columns: columnasGrid, spacing: 20.0){
                    //Listado de datos
                    if datosJson.pokemonDatos.isEmpty {
                        
                        VStack(alignment: .center){
                            Text("Cargando datos")
                            ProgressView()
                        }
                        .padding()

                    }else{
                        ForEach(datosJson.pokemonDatos, id: \.id){pokemon in
                            // Creo una instancia de Card
                            let pokemonCard = PokemonCard(pokemon: pokemon)
                            
                            NavigationLink(destination: PokemonDetalle(pokemon: pokemon)) {
                                    pokemonCard
                                    .id(pokemon.id)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pokedex")
            .foregroundColor(.white)// Elimina el título predeterminado
            .navigationBarBackButtonHidden(true) // Elimina la flecha hacia atrás predeterminada
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .toolbar {
                // Modifica el diseño del navigationTitle y agrega espacio en blanco
                ToolbarItem(placement: .topBarLeading) {
                    VStack {
                            Image(systemName: "arrow.backward")
                                .font(.title)
                                .imageScale(.small) // Cambia el tamaño de la flecha
                                .foregroundColor(.black) // Cambia el color de la flecha
                                .padding(.top, 30)
                                .padding(.bottom, 30)
                                .padding(.trailing, 70 )
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
    PokemonListado()
}
