//
//  MainViewController.swift
//  Stacked
//
//  Created by Raj Jakasaniya on 25/07/20.
//  Copyright © 2020 Vinayak Deshpande. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var stackedView: StackedView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        stackedView = StackedView(self)
        self.view.addSubview(stackedView)
        setupStackedView()
    }
    
    func setupStackedView() {
        NSLayoutConstraint.activate([
            stackedView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            stackedView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            stackedView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            stackedView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
}

extension MainViewController: StackedViewDelegate {
    func stackedView(stackedView: StackedView, titleForCTAAt index: Int) -> String {
        switch index {
        case 0:
            return "Proceed to EMI Selection"
        case 1:
            return "Select your bank account"
        case 2:
            return "Tap for 1-click KYC"
        default:
            return ""
        }
    }
    
    func stackedView(stackedView: StackedView, didSelectViewAt index: Int, completion: ((Bool) -> ())?) {
        switch index {
        case 0:
            let alert = UIAlertController(title: "Wait", message: "Please wait for 2 seconds to see effect", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                alert.dismiss(animated: true, completion: nil)
                print("Hello")
                completion?(true)
            }
            return
        case 1:
            print("World")
            completion?(true)
        default:
            print("none")
        }
    }
    
    func stackedView(stackedView: StackedView, titleAndSubTitleAt index: Int) -> TopViewDetail {
        switch index {
        case 0:
            var topDetail = TopViewDetail()
            topDetail.titles = ["Credit amount"]
            topDetail.subTitles = ["1,50,000"]
            return topDetail
        case 1:
            var topDetail = TopViewDetail()
            topDetail.titles = ["EMI", "Duration"]
            topDetail.subTitles = ["27000/month", "2 years"]
            return topDetail
        default:
            var topDetail = TopViewDetail()
            topDetail.titles = []
            topDetail.subTitles = []
            return topDetail
        }
    }
    
    func stackedView(stackedView: StackedView, viewForItemAt index: Int) -> UIView {
        switch index {
        case 0:
            return DemoView(text: "1", color: .red)
        case 1:
            return DemoView(text: "2", color: .green)
        case 2:
            return DemoView(text: "3", color: .gray)
        default:
            return UIView()
        }
    }
    
    func number(ofViewIn stackedView: StackedView) -> Int {
        return 3
    }
    
    
}
