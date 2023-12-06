//
//  HomeView.swift
//  pokedex-app-cenco
//
//  Created by Marco Cordoba on 06-12-23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    Spacer()
                    Text("Pokedex")
                        .font(Font.system(size: 32,weight: .heavy))
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .padding(.top, -20)
                        .padding(.bottom, 5)
                    Spacer()
                }
                
                Text("List of 100 pokemon, showing detailed information about each one. you can save your favorites in your list")
                    .padding(.bottom, 20)
                    .padding(.horizontal, 30)
                    .multilineTextAlignment(.center)
                
                PokemonListado()
                
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
    }
}

#Preview {
    HomeView()
}
