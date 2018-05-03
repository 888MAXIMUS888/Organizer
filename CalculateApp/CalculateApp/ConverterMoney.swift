//
//  ConverterViewController.swift
//  CalculateApp
//
//  Created by iMaxiOS on 4/27/18.
//  Copyright © 2018 iMaxiOS. All rights reserved.
//

import UIKit
import AudioToolbox

struct Currency: Decodable {
    let base: String
    let date: String
    let rates: [String: Double]
}

class ConverterMoney: UIViewController, UITableViewDataSource  {
    
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var moneyTableView: UITableView!
    
    var eur: Currency?
    var baseRate = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moneyTableView.dataSource = self
        moneyTableView.allowsSelection = false
        //        converterTableView.showsVerticalScrollIndicator = false
        valueTextField.textAlignment = .center
        fetchData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currunceFetch = eur {
            return currunceFetch.rates.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        if let currenceFetch = eur {
            cell.textLabel?.text = Array(currenceFetch.rates.keys)[indexPath.row]
            let selectedRate = baseRate * Array(currenceFetch.rates.values)[indexPath.row]
            cell.detailTextLabel?.text = "\(selectedRate)"
            return cell
        }
        return UITableViewCell()
    }
    
    func fetchData() {
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=4b31b25d7219502b6149a4204add41f1&format=1&base=EUR&symbols=USD,AUD,CAD,PLN,MXN,RUB,UAH,CZK,KZT,MAD,PKR,TND")
        URLSession.shared.dataTask(with: url!) { (data, respopnse, error) in
            if error == nil {
                
                do {
                    self.eur = try JSONDecoder().decode(Currency.self, from: data!)
                    
                } catch {
                    print("Parse Error")
                }
                
                DispatchQueue.main.async {
                    self.moneyTableView.reloadData()
                }
                
            }else {
                print("Error")
            }
        }.resume()
    }
    
    @IBAction func convertButton(_ sender: UIButton) {
        
        AudioServicesPlayAlertSound(SystemSoundID(1008))
        if let getConvert = valueTextField.text {
            if let isDouble = Double(getConvert){
                baseRate = isDouble
                fetchData()
            }
        }
    }
    
    @IBAction func convertorTwoButton(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let converterMoney = storyboard.instantiateViewController(withIdentifier: "ConverterTwo")
        present(converterMoney, animated: true, completion: nil)
        
    }
}





