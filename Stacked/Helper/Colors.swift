//
//  Colors.swift
//  Scanner
//
//  Created by Raj Jakasaniya on 25/07/20.
//  Copyright © 2020 Vinayak Deshpande. All rights reserved.
//

import UIKit

enum Colors {
    case primaryBackground
    case secondaryBackground
    case primaryButton
}

extension Colors: RawRepresentable {
    typealias RawValue = UIColor
    
    init?(rawValue: UIColor) {
        switch rawValue {
        case UIColor(red: 242/255, green: 247/255, blue: 250/255, alpha: 1):
            self = .primaryBackground
        case UIColor(red: 234/255, green: 238/255, blue: 242/255, alpha: 1):
            self = .secondaryBackground
        case UIColor(red: 60/255, green: 49/255, blue: 203/255, alpha: 1):
            self = .primaryButton
        default:
            return nil
        }
    }
    
    var rawValue: UIColor {
        switch  self {
        case .primaryBackground:
            return UIColor(red: 242/255, green: 247/255, blue: 250/255, alpha: 1)
        case .secondaryBackground:
            return UIColor(red: 234/255, green: 238/255, blue: 242/255, alpha: 1)
        case .primaryButton:
            return  UIColor(red: 60/255, green: 49/255, blue: 203/255, alpha: 1)
        }
    }
}
