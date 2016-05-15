//
//  ViewController.swift
//  Calculator
//
//  Created by Yi Hua on 5/15/16.
//  Copyright © 2016 Hawaiii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInMiddleOfTyping = false
    
    @IBAction func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInMiddleOfTyping = true
    }
 

    @IBAction func performOperation(sender: UIButton) {
        userIsInMiddleOfTyping = false
        if let mathSymbol = sender.currentTitle {
            if mathSymbol == "π" {
                display.text = String(M_PI)
            }
        }
    }
}

