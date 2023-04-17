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
        DispatchQueue.main.async {
            self.prepareUI()
            
            var charIndex = 0.0
            let titleText = "Fontaine  "
            var currentText = ""
            
            let group = DispatchGroup()
            
            for letter in titleText {
                group.enter()
                Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { [weak self] (timer) in
                    currentText.append(letter)
                    self?.fontaineLabel.text = currentText
                    group.leave()
                }
                charIndex += 1
            }
            group.notify(queue: .main) {
                self.performSegue(withIdentifier: "welcomeSegue", sender: self)
            }
        }
    }

    
    func prepareUI() {
        let font = UIFont(name: "ABeeZee Regular", size: 60.0)
        fontaineLabel.font = font
        fontaineLabel.text = ""
    }
}
