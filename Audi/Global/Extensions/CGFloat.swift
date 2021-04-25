//
//  CGFloat.swift
//  Audi
//
//  Created by EVGENII DUKA on 14.04.2021.
//

import Foundation
import CoreGraphics

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
