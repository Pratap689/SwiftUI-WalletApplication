//
//  ColorGrid.swift
//  WalletAppAnimation
//
//  Created by netset on 28/02/22.
//

import SwiftUI
struct ColorGrid: Identifiable  {
    var id = UUID().uuidString
    var color: Color
    var hexValue: String
    
    //MARK: Animation Properties
    var rotateCards: Bool = false
    var showText: Bool = false
    var removeFromView: Bool = false
    var addToGrid: Bool = false
}
