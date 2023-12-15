//
//  FavoritePokemon+CoreDataProperties.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 4/12/23.
//
//

import Foundation
import CoreData


extension FavoritePokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritePokemon> {
        return NSFetchRequest<FavoritePokemon>(entityName: "FavoritePokemon")
    }

    @NSManaged public var attribute: NSObject?

}

extension FavoritePokemon : Identifiable {

}
