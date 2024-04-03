//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Enhanced by Dennis Tarasula on March 30, 2024
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
    }
    
    var performingMath = false
    var chainedEquals = false
    var model = CalculatorModel()
    var temp = 0.0
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        guard let numPressed = sender.title(for: .normal) else { return }
        
        if performingMath || chainedEquals {
            displayLabel.text = (numPressed == ".") ? "0." : numPressed
            performingMath = false
            chainedEquals = false
        } else {
            if displayLabel.text == "0" {
                displayLabel.text = (numPressed == ".") ? "0." : numPressed
            } else if !(displayLabel.text!.contains(".") && numPressed == ".") {
                displayLabel.text! += numPressed
            }
        }
        model.currentNum = Double(displayLabel.text!)!
    }
    
    @IBAction func operatorButtonPressed(_ sender: UIButton) {
        guard let operation = sender.title(for: .normal) else { return }
        
        switch operation {
            case "=":
            model.currentNum = Double(displayLabel.text!)!
            if !chainedEquals {
                temp = model.currentNum
                let result = model.performOperation(with: model.currentNum)
                displayLabel.text = String(result)
                chainedEquals = true
            } else {
                model.previousNum = model.currentNum
                model.currentNum = temp
                let result = model.performOperation(with: model.currentNum)
                displayLabel.text = String(result)
            }
            case "AC":
                model.reset()
                displayLabel.text = "0"
                performingMath = false
                chainedEquals = false
            default:
                model.setOperation(operation)
                model.previousNum = Double(displayLabel.text!)!
                performingMath = true
                chainedEquals = false
        }
    }
    
    @IBAction func functionButtonPressed(_ sender: UIButton) {
        guard let function = sender.title(for: .normal) else { return }
        
            model.setFunction(function)
            model.currentNum = Double(displayLabel.text!)!
            let result = model.performFunction(with: model.currentNum)
            displayLabel.text = String(result)
    }
}
