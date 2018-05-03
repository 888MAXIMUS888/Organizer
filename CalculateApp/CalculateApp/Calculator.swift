//
//  ViewController.swift
//  CalculateApp
//
//  Created by iMaxiOS on 4/24/18.
//  Copyright © 2018 iMaxiOS. All rights reserved.
//

import UIKit
import AudioToolbox

class Calculator: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var stillTyping = false
    var dotIsPlaced = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSing: String = ""
    
    var currentInput: Double {
        
        get {
            return Double(outputLabel.text!)!
        }
        
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                outputLabel.text = "\(valueArray[0])"
            } else {
                outputLabel.text = "\(newValue)"
            }
            
            stillTyping = false
        }
    }
    
    func preferredStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLabel.text = "0"
        
    }
    
    @IBAction func numberPressed(_ sender: RoundButton) {
        
        AudioServicesPlaySystemSound(SystemSoundID(1306))
        let number = sender.currentTitle!
        
        if stillTyping {
            if (outputLabel.text?.characters.count)! < 30 {
                outputLabel.text = outputLabel.text! + number
            }
        } else {
            outputLabel.text = number
            stillTyping = true
        }
    }
    
    @IBAction func clearPressed(_ sender: RoundButton) {
        
        AudioServicesPlayAlertSound(SystemSoundID(1001))
        
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        outputLabel.text = "0"
        stillTyping = false
        dotIsPlaced = false
        operationSing = ""
        
    }
    
    @IBAction func dotPressed(_ sender: RoundButton) {
        
        if stillTyping && !dotIsPlaced {
            outputLabel.text = outputLabel.text! + "."
            dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced {
            outputLabel.text = "0."
        }
    }
    
    @IBAction func twoOperandsSingPressend(_ sender: RoundButton) {
        operationSing = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
        dotIsPlaced = false
    }
    
    @IBAction func equalPressed(_ sender: RoundButton) {
        
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operationSing {
        case "÷":
            operateWithTwoOperands{$0 / $1}
        case "×":
            operateWithTwoOperands{$0 * $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "+":
            operateWithTwoOperands{$0 + $1}
        default: break
            
        }
    }
    
    @IBAction func converterMoneyButton(_ sender: RoundButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let calculator = storyboard.instantiateViewController(withIdentifier: "ConverterMoney")
        present(calculator, animated: true, completion: nil)
        
    }
    
    @IBAction func converterTwoButton(_ sender: RoundButton) {
        
        let storybourd = UIStoryboard(name: "Main", bundle: nil)
        let calculator = storybourd.instantiateViewController(withIdentifier: "ConverterTwo")
        present(calculator, animated: true, completion: nil)
        
    }
}









