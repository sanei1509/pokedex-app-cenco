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
                HStack{
                    Spacer()
                    Text("Pokedex")
                        .font(Font.system(size: 32,weight: .heavy))
                         .fontWeight(.black)
                         .foregroundColor(.white)
                         .padding(.top, -20)
                         .padding(.bottom, 5)
                    Spacer()
                }
                
                // Botón flotante con círculo e ícono de lista de favoritos
                VStack {
                    Spacer()
                    HStack {
                    NavigationLink(destination: FavoritesView()) {
                        Circle()
                            .fill(Color.white) // Color de fondo del círculo
                            .frame(width: 45, height: 45)
                            .overlay(Image(systemName: "list.bullet") // Ícono de favoritos, puedes cambiarlo por "list.bullet" si prefieres
                                .foregroundColor(.black) // Color del ícono
                                .fontWeight(.bold)
                                .font(.title2)
                            )
                        }
                    }.padding(.bottom, 10)
                }


                
                Text("List of 100 pokemon, showing detailed information about each one. you can save your favorites in your list")
                    .padding(.bottom, 20)
                    .padding(.horizontal, 30)
                    .multilineTextAlignment(.center)
                
                
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
                //indico fin del listado
                VStack{
                    Spacer()
                    Text("llegaste al fin del listado..")
                        .foregroundColor(.white)
                        .fontWeight(.light)
                        .font(.caption)
                        .padding(.top, 20)
                        .padding(.bottom, 5)
                    Spacer()
                }
            }
            .padding(.horizontal, 10)
            .foregroundColor(.white)
            .navigationTitle("Pokedex")
            .navigationBarTitleDisplayMode(.inline)
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
        .navigationTitle("Pokedex")
        .foregroundColor(.white)
        .navigationBarTitleDisplayMode(.inline)
        

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
