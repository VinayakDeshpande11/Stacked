//
//  CustomContainerView.swift
//  Stacked
//
//  Created by Raj Jakasaniya on 25/07/20.
//  Copyright © 2020 Vinayak Deshpande. All rights reserved.
//

import UIKit


class CustomContainerView: UIView {
    var isExpanded = true
    var heightConstraint: NSLayoutConstraint?
    var count = 0
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.regular(size: 12).rawValue
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.blue
        return label
    }()
    var titleLabel1: UILabel = {
        let label = UILabel()
        label.font = Fonts.regular(size: 12).rawValue
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.blue
        return label
    }()
    var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.semiBold(size: 16).rawValue
        label.text = ""
        label.textColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var subTitleLabel1: UILabel = {
        let label = UILabel()
        label.font = Fonts.semiBold(size: 16).rawValue
        label.text = ""
        label.textColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var topMsgContainerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var topMsgContainerRightView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var topContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var downArrowImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "downArrow")
        return image
    }()
    var ctaButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = Fonts.medium(size: 14).rawValue
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 15
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return button
    }()
    var shadowView: UIView = {
        var view = UIView()
        view.layer.zPosition = 1
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowRadius = 10
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(shadowView)
        shadowView.addSubview(topContainerView)
        topContainerView.addSubview(topMsgContainerView)
        topContainerView.addSubview(topMsgContainerRightView)
        topMsgContainerView.addSubview(titleLabel)
        topMsgContainerView.addSubview(subTitleLabel)
        topMsgContainerRightView.addSubview(titleLabel1)
        topMsgContainerRightView.addSubview(subTitleLabel1)
        topContainerView.addSubview(actionButton)
        topContainerView.addSubview(downArrowImage)
        shadowView.addSubview(containerView)
        shadowView.addSubview(ctaButton)
        ctaButton.clipsToBounds = true
        self.backgroundColor = UIColor.white

        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupTopContainer()
        setupTopMsgContainer()
        setupTitle()
        setupSubTitle()
        setupTitle1()
        setupSubTitle1()
        setupTopMsgRightContainer()
        setupButton()
        setupCTAButton()
        setupShadoView()
        setupContainerView()
        setupImageInTopContainer()
    }
    
    func setupTopMsgContainer() {
        NSLayoutConstraint.activate([
            topContainerView.topAnchor.constraint(equalTo: topMsgContainerView.topAnchor, constant: -16),
            topContainerView.leadingAnchor.constraint(equalTo: topMsgContainerView.leadingAnchor, constant: -16)
        ])
    }
    func setupTopMsgRightContainer() {
        NSLayoutConstraint.activate([
            topMsgContainerRightView.centerYAnchor.constraint(equalTo: topMsgContainerView.centerYAnchor, constant: 0),
            topMsgContainerRightView.leadingAnchor.constraint(equalTo: topMsgContainerView.trailingAnchor, constant: 48)
        ])
    }
    func setupTopContainer() {
        NSLayoutConstraint.activate([
            topContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            topContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            topContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            topContainerView.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    func setupTitle() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topMsgContainerView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: topMsgContainerView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: topMsgContainerView.trailingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor, constant: 0)
        ])
    }
    func setupSubTitle() {
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: topMsgContainerView.leadingAnchor, constant: 0),
            subTitleLabel.trailingAnchor.constraint(equalTo: topMsgContainerView.trailingAnchor, constant: 0),
            subTitleLabel.bottomAnchor.constraint(equalTo: topMsgContainerView.bottomAnchor, constant: 0)
        ])
    }
    func setupTitle1() {
        NSLayoutConstraint.activate([
            titleLabel1.topAnchor.constraint(equalTo: topMsgContainerRightView.topAnchor, constant: 0),
            titleLabel1.leadingAnchor.constraint(equalTo: topMsgContainerRightView.leadingAnchor, constant: 0),
            titleLabel1.trailingAnchor.constraint(equalTo: topMsgContainerRightView.trailingAnchor, constant: 0),
            titleLabel1.bottomAnchor.constraint(equalTo: subTitleLabel1.topAnchor, constant: 0)
        ])
    }
    func setupSubTitle1() {
        NSLayoutConstraint.activate([
            subTitleLabel1.leadingAnchor.constraint(equalTo: topMsgContainerRightView.leadingAnchor, constant: 0),
            subTitleLabel1.trailingAnchor.constraint(equalTo: topMsgContainerRightView.trailingAnchor, constant: 0),
            subTitleLabel1.bottomAnchor.constraint(equalTo: topMsgContainerRightView.bottomAnchor, constant: 0)
        ])
    }
    func setupButton() {
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 0),
            actionButton.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: 0),
            actionButton.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 0),
            actionButton.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 0)
        ])
    }
    func setupCTAButton() {
        let bottomAnchr = ctaButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)
        bottomAnchr.priority = UILayoutPriority(750)
        NSLayoutConstraint.activate([
            ctaButton.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 0),
            ctaButton.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: 0),
            ctaButton.heightAnchor.constraint(equalToConstant: 55),
            ctaButton.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: 0),
            bottomAnchr
        ])
       
    }
    func setupShadoView() {
        NSLayoutConstraint.activate([
                   shadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
                   shadowView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
                   shadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
                   shadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
               ])
    }
    func setupContainerView() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            
        ])
    }
    func setupImageInTopContainer() {
        NSLayoutConstraint.activate([
            downArrowImage.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor),
            downArrowImage.heightAnchor.constraint(equalToConstant: 20),
            downArrowImage.widthAnchor.constraint(equalToConstant: 20),
            downArrowImage.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -16),
            downArrowImage.leadingAnchor.constraint(equalTo: topMsgContainerRightView.trailingAnchor, constant: 16)
        ])
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
