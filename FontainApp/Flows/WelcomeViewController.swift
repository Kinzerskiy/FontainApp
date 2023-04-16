//
//  WelcomeViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 16.04.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var fontaineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var charIndex = 0.0
        let titleText = "Fontaine"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.fontaineLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    func prepareUI() {
        var font = UIFont(name: "ABeeZee Regular", size: 60.0)
        fontaineLabel.font = font
        fontaineLabel.text = ""
    }
}
