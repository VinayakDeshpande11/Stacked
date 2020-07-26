//
//  StackedView.swift
//  Stacked
//
//  Created by Raj Jakasaniya on 25/07/20.
//  Copyright © 2020 Vinayak Deshpande. All rights reserved.
//

import UIKit

@propertyWrapper struct MaxArraySize {
    private var array: [String]
    init() {
        self.array = []
    }
    var wrappedValue: [String] {
        get {return array}
        set {array = newValue.count > 2 ? newValue.dropLast(newValue.count-2) : newValue}
    }
}

struct TopViewDetail {
    @MaxArraySize var titles:[String]
    @MaxArraySize var subTitles:[String]
}

protocol StackedViewDelegate {
    func number(ofViewIn stackedView: StackedView) -> Int
    func stackedView(stackedView: StackedView, viewForItemAt index: Int) -> UIView
    func stackedView(stackedView: StackedView, titleAndSubTitleAt index: Int) -> TopViewDetail
    func stackedView(stackedView: StackedView, didSelectViewAt index: Int, completion: ((Bool)->())?)
    func stackedView(stackedView: StackedView, titleForCTAAt index: Int) -> String
}

class StackedView: UIView {
    var delegate: StackedViewDelegate?
    private var totalCount = 0
    private var count: CGFloat = 0
    private var customViews = [CustomContainerView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(_ delegate: StackedViewDelegate?) {
        guard let delegate = delegate else {
            fatalError("Set delegate and implement the delegate functions")
        }
        self.delegate = delegate
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        totalCount = delegate.number(ofViewIn: self)
        for _ in 0..<totalCount {
            customViews.append(CustomContainerView())
        }
        configure(customViews)
        self.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(_ views: [CustomContainerView]) {
        customViews.forEach {
            self.addSubview($0)
            count+=1
            $0.count = Int(count)
            $0.actionButton.tag = Int(count-1)
            $0.topContainerView.isHidden = true
            $0.ctaButton.tag = Int(count-1)
            setupView($0)
            if count == 1 {
                $0.isHidden = false
                if !$0.containerView.subviews.contains(where: {$0.isKind(of: DemoView.self)}) {
                    let internalView =  (delegate?.stackedView(stackedView: self, viewForItemAt: Int(count-1)))!
                    internalView.translatesAutoresizingMaskIntoConstraints = false
                    $0.containerView.addSubview(internalView)
                    $0.ctaButton.setTitle(delegate?.stackedView(stackedView: self, titleForCTAAt: Int(count-1)), for: .normal)
                    NSLayoutConstraint.activate([
                        $0.containerView.topAnchor.constraint(equalTo: internalView.topAnchor),
                        $0.containerView.bottomAnchor.constraint(equalTo: internalView.bottomAnchor),
                        $0.containerView.leadingAnchor.constraint(equalTo: internalView.leadingAnchor),
                        $0.containerView.trailingAnchor.constraint(equalTo: internalView.trailingAnchor)
                    ])
                }
            } else {
                $0.isHidden = true
            }

            $0.actionButton.addTarget(self, action: #selector(collapse), for: .touchUpInside)
            $0.ctaButton.addTarget(self, action: #selector(expand), for: .touchUpInside)
        }
    }
    
    @objc private func expand(sender: UIButton) {
        guard sender.tag < customViews.count-1 else {
            delegate?.stackedView(stackedView: self, didSelectViewAt: sender.tag, completion: nil)
            return
        }
        delegate?.stackedView(stackedView: self, didSelectViewAt: sender.tag, completion: { (success) in
            if success {
                DispatchQueue.main.async {
                    let currentView = self.customViews[sender.tag]
                    let view = self.customViews[sender.tag+1]
                    view.ctaButton.setTitle(self.delegate?.stackedView(stackedView: self, titleForCTAAt: sender.tag+1), for: .normal)
                    view.heightConstraint?.constant = self.frame.height-(CGFloat(view.count))*75
                    let details = self.delegate?.stackedView(stackedView: self, titleAndSubTitleAt: sender.tag)
                    if !view.containerView.subviews.contains(where: {$0.isKind(of: DemoView.self)}) {
                        let internalView =  (self.delegate?.stackedView(stackedView: self, viewForItemAt: sender.tag+1))!
                        internalView.translatesAutoresizingMaskIntoConstraints = false
                        view.containerView.addSubview(internalView)
                        NSLayoutConstraint.activate([
                            view.containerView.topAnchor.constraint(equalTo: internalView.topAnchor),
                            view.containerView.bottomAnchor.constraint(equalTo: internalView.bottomAnchor),
                            view.containerView.leadingAnchor.constraint(equalTo: internalView.leadingAnchor),
                            view.containerView.trailingAnchor.constraint(equalTo: internalView.trailingAnchor)
                        ])
                    }
                    let zippedArray = Array(zip(details!.titles, details!.subTitles))
                    for (index, tuple) in zippedArray.enumerated() {
                        if index == 0 {
                            currentView.titleLabel.text = tuple.0
                            currentView.subTitleLabel.text = tuple.1
                        } else {
                            currentView.titleLabel1.text = tuple.0
                            currentView.subTitleLabel1.text = tuple.1
                        }
                    }
                    UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {[weak self] in
                        guard let self = self else {return}
                        view.isHidden = false
                        self.layoutIfNeeded()
                    })
                    UIView.animate(withDuration: 0.5) {
                        currentView.topContainerView.isHidden = false
                        currentView.containerView.isHidden = true
                        view.containerView.isHidden = false
                    }
                    view.isExpanded = !view.isExpanded
                }
            }
        })
        
    }
    
    @objc func collapse(sender: UIButton) {
        guard sender.tag < customViews.count-1 else {return}
        let currentView = customViews[sender.tag]
        for index in sender.tag..<customViews.count-1 {
            let view = customViews[index+1]
            
            view.heightConstraint?.constant = 0
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {[weak self] in
                guard let self = self else {return}
                view.isHidden = true
                self.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.5) {
                currentView.topContainerView.isHidden = true
                currentView.containerView.isHidden = false
            }
            view.isExpanded = !view.isExpanded
        }
    }
    
    func setupView(_ view: UIView)  {
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    override func layoutSubviews() {
        customViews.forEach {
            if !$0.constraints.contains(where: { $0.firstAttribute == .height }) {
                let height = $0.count == 1 ? $0.heightAnchor.constraint(equalToConstant: self.frame.height-CGFloat($0.count*75)) :   $0.heightAnchor.constraint(equalToConstant: 0)
                height.isActive = true
                $0.heightConstraint = height
            }
            
        }
    }
}

extension StackedView {
    func view(for index: Int) -> CustomContainerView? {
        index < customViews.count ? customViews[index] : nil
    }
}

