//
//  Fonts.swift
//  Scanner
//
//  Created by Raj Jakasaniya on 25/07/20.
//  Copyright © 2020 Vinayak Deshpande. All rights reserved.
//

import UIKit

enum Fonts {
    case bold(size: CGFloat)
    case medium(size: CGFloat)
    case regular(size: CGFloat)
    case semiBold(size: CGFloat)
    case thin(size: CGFloat)
}

extension Fonts: RawRepresentable {
    typealias RawValue = UIFont
    init?(rawValue: UIFont) {
        switch rawValue {
        case UIFont(name: "Montserrat-Bold", size: 8):
            self = .bold(size: 8)
        case UIFont(name: "Montserrat-Medium", size: 8):
            self = .medium(size: 8)
        case UIFont(name: "Montserrat-Regular", size: 8):
            self = .regular(size: 8)
        case UIFont(name: "Montserrat-SemiBold", size: 8):
            self = .semiBold(size: 8)
        case UIFont(name: "Montserrat-Thin", size: 8):
            self = .thin(size: 8)
        default:
            return nil
        }
    }
    
    var rawValue: UIFont {
        switch self {
        case .bold(let size):
            return UIFont(name: "Montserrat-Bold", size: size)!
        case .medium(let size):
            return UIFont(name: "Montserrat-Medium", size: size)!
        case .regular(let size):
            return UIFont(name: "Montserrat-Regular", size: size)!
        case .semiBold(let size):
            return UIFont(name: "Montserrat-SemiBold", size: size)!
        case .thin(let size):
            return UIFont(name: "Monserrat-Thin", size: size)!
        }
    }
}
