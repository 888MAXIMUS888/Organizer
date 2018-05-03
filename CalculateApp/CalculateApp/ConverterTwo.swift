//
//  ConverterTwo.swift
//  CalculateApp
//
//  Created by iMaxiOS on 4/30/18.
//  Copyright © 2018 iMaxiOS. All rights reserved.
//

import UIKit
import AudioToolbox

class ConverterTwo: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var unitsPicked: UIPickerView!
    
    var array = ["meters - inches","inches - meters", "second - minutes", "minutes - seconds", "fahrenheit - celcius", "celcius - fahrenheit"]
    var chosenRow = 0
    
    @IBAction func convertButton(_ sender: UIButton) {
        
        AudioServicesPlayAlertSound(SystemSoundID(1012))
        let value: Double? = Double(valueTextField.text!)
        //Meters to inches
        if chosenRow == 0 {
            resultLabel.text = String(value! * 39.3701)
            //inches to meters
        } else if chosenRow == 1 {
            resultLabel.text = String(value! / 39.3701)
            //seconds to minutes
        } else if chosenRow == 2 {
            resultLabel.text = String(value! / 60)
            //minutes to seconds
        } else if chosenRow == 3 {
            resultLabel.text = String(value! * 60)
            //fahrenheit to celcius
        } else if chosenRow == 4 {
            resultLabel.text = String((value! - 32) * (5/9))
            //celcius to fahrenheit
        } else if chosenRow == 5 {
            resultLabel.text = String((value! * (9/5)) + 32)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        unitsPicked.delegate = self
        unitsPicked.dataSource = self
        
    }
    
    @IBAction func converterMoneyButton(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let  converterTwo = storyboard.instantiateViewController(withIdentifier: "ConverterMoney")
        present(converterTwo, animated: true, completion: nil)
        
    }
    
}

extension ConverterTwo {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenRow = row
    }
}








