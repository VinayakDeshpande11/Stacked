//
//  DemoView.swift
//  Stacked
//
//  Created by Raj Jakasaniya on 25/07/20.
//  Copyright © 2020 Vinayak Deshpande. All rights reserved.
//

import UIKit

class DemoView: UIView {
    var label: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    init(text: String, color: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = .green
        self.layer.cornerRadius = 15
        self.label.text = text
        self.backgroundColor = color
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.addSubview(label)
        setupLabel()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupLabel() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
}
