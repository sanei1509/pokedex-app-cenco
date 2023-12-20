//
//  SwiftUIView.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 5/11/23.
//

import SwiftUI

struct PokemonListado: View {
    // Instancias necesitadas
    @StateObject var viewModel = PokemonListadoViewModel()
    

    private let columnasGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    // Probando UserDefaults
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columnasGrid, spacing: 20.0) {
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
            //indico fin del listado
        
            Spacer()
            Text("llegaste al fin del listado..")
                .foregroundColor(.white)
                .fontWeight(.light)
                .font(.caption)
                .padding(.top, 20)
                .padding(.bottom, 5)
            Spacer()
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
