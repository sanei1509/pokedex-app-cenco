//
//  ContentView.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 3/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color(.yellow).ignoresSafeArea(.all)
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Pokedex WIP!!")
                }
                .padding()
                .navigationTitle("Listado")
            }
        }
    }
}

#Preview {
    ContentView()
}
