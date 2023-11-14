//
//  LoadPokemonDetailUseCase.swift
//  pokedex-app-cenco
//
//  Created by Marco Cordoba on 14-11-23.
//

import Foundation

final class LoadPokemonDetailUseCase {
    
    let repository: PokemonDetailRepository = PokemonDetailRepository()
    func loadPokemonDetail(idPokemon: String) async -> PokemonDetailEntity? {
        let pokemonModel = await repository.pokemonDetail(id: idPokemon)
        return PokemonDetailMapper.mapperPokemonDetail(model: pokemonModel)
    }
}
