//
//  CustomPath.swift
//  WalletAppAnimation
//
//  Created by netset on 28/02/22.
//

import Foundation
import SwiftUI

struct CustomPath: Shape {
    let radius: CGFloat
    let corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
