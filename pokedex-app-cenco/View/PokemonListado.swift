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
//                    ForEach(PokemonList){ pokemon in
//                        PokemonCard(pokemon: pokemon)
//                    }
                    //Listado de datos
                    if datosJson.pokemonDatos.isEmpty {
                        ProgressView()
                    }else{
                        List(datosJson.pokemonDatos, id:\.id) { pokemon in
                            VStack(alignment: .leading){
                                Text("Hola")
                                Text(pokemon.name)
                            }
                        }
                    }
                }
            }.navigationTitle("Listado")
        }
    }
}

#Preview {
    ListadoPokemon()
}
