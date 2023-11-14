//
//  PokemonDetailRepository.swift
//  pokedex-app-cenco
//
//  Created by Marco Cordoba on 14-11-23.
//

import Foundation

class PokemonDetailRepository {
    let remote: PokemonDetailRemote = PokemonDetailRemoteImpl()
    func pokemonDetail(id: String, isRemote: Bool = true) async -> PokemonDetails? {
        if (isRemote) {
            return await remote.loadPokemonDetail(id: id)
        }
        return nil
    }
}
