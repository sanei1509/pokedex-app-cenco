//
//  PokemonDetailEntity.swift
//  pokedex-app-cenco
//
//  Created by Marco Cordoba on 14-11-23.
//

import Foundation

struct PokemonDetailEntity {
    let name: String
    let type: String
    let image: String?
}

enum PokemonDetailMapper {
    
    static func mapperPokemonDetail(model: PokemonDetails?) -> PokemonDetailEntity? {
        return PokemonDetailEntity(
            name: "charmander1",
            type: "",
            image: model?.sprites.other.filter({$0.key == "official-artwork" })
                .map({ images in images.value.frontDefault }).first
        )
    }
}
