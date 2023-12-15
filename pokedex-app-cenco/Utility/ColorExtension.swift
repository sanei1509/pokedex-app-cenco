//
//  ColorExtension.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 13/12/23.
//

import Foundation
import SwiftUI

extension Color {
  static let customGreenLight = Color("ColorGreenLight")
  static let customGreenMedium = Color("ColorGreenMedium")
  static let customGreenDark = Color("ColorGreenDark")
  static let customGrayLight = Color("ColorGrayLight")
  static let customGrayMedium = Color("ColorGrayMedium")
  static let customIndigoMedium = Color("ColorIndigoMedium")
  static let customSalmonLight = Color("ColorSalmonLight")
 //agregar colores a fin con el mundo pokemon
    
}

// extension para poder poner colores hexadecimales
extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

func backgroundColor(forType type:String)-> Color{
    switch type{
    case "fire": return Color(hex:"#F7786A")
    case "poison": return Color(hex:"#ad6dc6")
    case "water": return Color(hex:"#58abf6")
    case "electric": return Color(hex:"#fece4a")
    case "psychic": return Color(hex:"#d660a7")
    case "ground": return Color(hex:"#CA8079")
    case "normal": return Color(hex:"#b6aac4")
    case "flying": return Color(hex:"#94B2C7")
    case "fairy": return Color(hex:"#edafdd")
    case "bug": return Color(hex:"#73a07d")
    case "grass": return Color(hex:"#61E3C3")
    default : return Color(hex:"#aaaaaa")
    }
}
