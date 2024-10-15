//
//  DistrictViewController.swift
//  TabliceRejestracyjne
//
//  Created by Bartłomiej Prędki on 23/10/2023.
//

import UIKit

class DistrictViewController: UITableViewController {
    
    private var districtArray:[String] = []
    private var http = ""
    private var selectedDistrict = ""
    var selectors:[String] = []
    var selectedVoivodship2 = ""

    var districts:NSDictionary? {
        didSet {
            for k in districts!.allKeys {
                if let d = k as? String {
                    if d != "wyr" {
                        districtArray.append(d)
                    }
                }
                districtArray.sort { $0.compare($1, locale: NSLocale.current) == .orderedAscending }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return districtArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = districtArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDistrict = districtArray[indexPath.row]
        performSegue(withIdentifier: "segueDetails", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NewDistrictViewController {
            if let plates = districts?[selectedDistrict] as? NSArray {
                destination.plates = plates
                destination.selectors = selectors
                destination.selectedVoivodship = selectedVoivodship2
                destination.selectedSelector = selectedDistrict
                destination.title = selectedDistrict
            }
        }
    }


}
