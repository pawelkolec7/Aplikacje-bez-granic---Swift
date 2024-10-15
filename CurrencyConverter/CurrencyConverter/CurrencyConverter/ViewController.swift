//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Bartłomiej Prędki on 12/10/2023.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    private let currencies = ["PLN","EUR","USD","GBP","CHF"]
    private var rates = [String:Double]()
    private var from = 0, to = 0
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var pickerCurrencies: UIPickerView!
    @IBOutlet weak var labelOutput: UILabel!
    
    @IBAction func textChanged(_ sender: Any) {
        convertValue()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            from = row
            textField.placeholder = "Wprowadź kwotę w \(currencies[from])"
        case 1:
            to = row
            labelOutput.text = "Kwota w \(currencies[to])"
        default:
            return
        }
        convertValue()
    }
    
    func convertValue() {
        var rate = 1.0
        var key = "\(currencies[from])-\(currencies[to])"
        if rates.keys.contains(key) {
            rate = rates[key]!
        } else {
            key = "\(currencies[to])-\(currencies[from])"
            if rates.keys.contains(key) {
                rate = 1/rates[key]!
            }
        }
        
        if let input = textField.text {
            if let value = Double(input) {
                let result = value * rate
                labelOutput.text = "\(String(format: "%.2f",result)) \(currencies[to])"
            } else {
                labelOutput.text = "Wprowadź prawidłową kwotę"
            }
        } else {
            labelOutput.text = "Wprowadź prawidłową kwotę"
        }
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.endEditing(true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData { (dict,error) in
            if let d = dict {
                for k in d.keys {
                    let rate = Double(d[k]!)
                    self.rates[k] = rate
                }
            }
        }
    }

    func fetchData(completion: @escaping ([String:String]?, Error?) -> Void) {
        let url = URL(string: "https://fcds.cs.put.poznan.pl/MyWeb/Media/currencies.json")!
        
        let task = URLSession.shared.dataTask(with: url) { (data,response,error) in
            guard let data = data else { return }
            do {
                if let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:String] {
                    completion(dict,nil)
                }
            }
            catch {
                print(error)
                completion(nil,error)
            }
        }
        task.resume()
    }

}

