//
//  PokemonDetailRemote.swift
//  pokedex-app-cenco
//
//  Created by Marco Cordoba on 14-11-23.
//

import Foundation

class PokemonDetailRemoteImpl: PokemonDetailRemote {
    func loadPokemonDetail(id: String) async -> PokemonDetails? {
        if let url = URL.init(string: ConstantsGeneral.urlDetail) {
            let data = try? await URLSession.shared.data(from: url)
            if let data = data {
                if let detail = try? JSONDecoder().decode(PokemonDetails.self, from: data.0) {
                    return detail
                }
            }
        }
        return nil
    }
}

protocol PokemonDetailRemote {
    func loadPokemonDetail(id: String) async -> PokemonDetails?
}


enum ConstantsGeneral {
    static let urlDetail = "https://pokeapi.co/api/v2/pokemon/"
}
