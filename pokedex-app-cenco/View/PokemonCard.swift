//
//  SwiftUIView.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//
import SwiftUI

struct PokemonCard: View {
//    let pokemon:Pokemon2
//    @ObservedObject var viewModel = PokemonViewModel()
    var body: some View {
        ZStack{
            Color(.white).ignoresSafeArea(.all)
            //POKEMON CARD
            ZStack{
                VStack{
                    //llamo a la clase pokemon
                    Text("pokemon.name".uppercased())
                        .bold().foregroundColor(.white)
                        .font(.headline)
                    HStack{
                        // types / type ./name
                        Text("Pokemon.type")
                            .font(.caption)
                            .foregroundColor(.white)
                            .bold()
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).fill(.white.opacity(0.25)))
                            .frame(width: 80, height: 25)
                        // sprites / oficial-artwork / front_default
                        Image("1").resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                    }
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 10)
            .padding(.horizontal, 8)
            .background(Color(.green/*backgroundColor(forType: pokemon.type)*/))
            .cornerRadius(20)
            .shadow(color: Color(.green)/*Color(backgroundColor(forType: pokemon.type))*/, radius: 10, x: 0.0, y:0.0)
        }
    }
}


struct PokemonCard_preview: PreviewProvider {
    static var previews: some View{
        Group {
//            PokemonCard(pokemon: PokemonList[1])
            PokemonCard()
        }.previewLayout(.fixed(width: 200, height: 200))
    }
}
