//
//  WelcomeViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 16.04.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var fontaineLabel: UILabel!
    
    var viewModel = WelcomeViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        prepareUI()
        
        var charIndex = 0.0
        let titleText = "Fontaine"
        let titleCount = Double(titleText.count)
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { [charIndex] (timer) in
                self.fontaineLabel.text?.append(letter)
                if charIndex == titleCount - 1 {
                    self.performSegue(withIdentifier: "welcomeSegue", sender: self)
                }
            }
            charIndex += 1
        }
    }
    
    func prepareUI() {
        let font = UIFont(name: "ABeeZee Regular", size: 60.0)
        fontaineLabel.font = font
        fontaineLabel.text = ""
    }
}
