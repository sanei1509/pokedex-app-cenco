//
//  ContentView.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 3/11/23.
//

import SwiftUI

struct PokemonView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color(.white).ignoresSafeArea(.all)
                //POKEMON CARD
                ZStack{
                    Text("Pokemon Name".uppercased())
                        .bold().foregroundColor(.white)
                        .font(.title)
                    
                }
                .padding(/*@START_MENU_TOKEN@*/.all, 30.0/*@END_MENU_TOKEN@*/)
                .background(.green)
                .shadow(color: .green, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0.0, y:0.0)
                .navigationTitle("Listado")
                
            }
        }
    }
}

#Preview {
    PokemonView()
}
