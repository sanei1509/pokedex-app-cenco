//
//  SwiftUIView.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 5/11/23.
//

import SwiftUI

struct PokemonListado: View {
    @StateObject var viewModel = PokemonListadoViewModel()
    private let columnasGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: columnasGrid, spacing: 20.0){
                    //Listado de datos
                    if viewModel.pokemonDatos.isEmpty {
                        
                        VStack(alignment: .center){
                            Text("Cargando datos")
                            ProgressView()
                        }
                        .padding()
                        
                    }else{
                        listadoCards
                    }
                }
            }
            .padding(.horizontal, 10)
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
    } // END THE VIEW
    
    private var listadoCards: some View {
        ForEach(viewModel.pokemonDatos, id: \.id) { pokemon in
            let pokemonCard = PokemonCard(pokemon: pokemon)
            
            NavigationLink(destination: PokemonDetalle(pokemon: pokemon)) {
                    pokemonCard
                    .id(pokemon.id)
            }
        }
    }
    // =======================
}

#Preview {
    PokemonListado()
}
