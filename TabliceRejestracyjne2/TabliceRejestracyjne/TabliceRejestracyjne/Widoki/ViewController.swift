//
//  ViewController.swift
//  TabliceRejestracyjne
//
//  Created by Bartłomiej Prędki on 20/10/2023.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {

    var dictionary:NSDictionary?
    var voivodships:[String] = []
    var selectedVoivodship = ""
    var foundDistrict = ""
    var foundDistrictPlates:NSArray?
    var selectedSelectors: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let bundleURL = Bundle.main.url(forResource: "tablice", withExtension: "plist")!
        dictionary = NSDictionary(contentsOf: bundleURL)
        if let v = dictionary?["Województwa"] as? NSDictionary {
            for k in v.allKeys {
                if let w = k as? String {
                    voivodships.append(w)
                }
            }
            voivodships.sort { $0.compare($1, locale: NSLocale.current) == .orderedAscending }
        }
        self.title = "Wybierz województwo"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voivodships.count + 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < voivodships.count && voivodships.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellVoivodship", for: indexPath as IndexPath) as! VoivodshipTableViewCell
            cell.labelVoivodship.text = voivodships[indexPath.row]
            cell.labelSelectors.text = arrayToString(strings: getSelectors(for: voivodships[indexPath.row]))
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellSearch", for: indexPath as IndexPath) as! SearchTableViewCell
            cell.searchBar.delegate = self
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < voivodships.count {
            selectedVoivodship = voivodships[indexPath.row]
            selectedSelectors = getSelectors(for: voivodships[indexPath.row])
            performSegue(withIdentifier: "segueDistricts", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "segueDistricts":
            if let destination = segue.destination as? DistrictViewController {
                if let vships = dictionary?["Województwa"] as? NSDictionary {
                    if let district = vships[selectedVoivodship] as? NSDictionary
                    {
                        destination.districts = district
                        destination.title = selectedVoivodship
                        destination.selectors = selectedSelectors!
                        destination.selectedVoivodship2 = selectedVoivodship
                    }
                }
            }
        case "segueSearchResults":
            if let destination = segue.destination as? NewDistrictViewController {
                destination.plates = foundDistrictPlates
                destination.selectors = selectedSelectors ?? []
                destination.title = foundDistrict
                destination.selectedVoivodship = selectedVoivodship
                destination.selectedSelector = foundDistrict
            }
        default:
            return
        }
    }
    
    func getSelectors(for voivodship:String) -> [String] {
        if let root = dictionary?["Województwa"] as? NSDictionary {
            if let v = root[voivodship] as? NSDictionary {
                if let selectors = v["wyr"] as? [String] {
                    var sel:[String] = []
                    for s in selectors {
                        sel.append(s)
                    }
                    return sel
                }
            }
        }
        return []
    }
    
    
    func arrayToString(strings: [String]) -> String {
        guard strings.count > 0 else { return "" }
        var res = ""
        for s in strings {
            res.append(s)
            res.append(",")
        }
        let end = res.count-1
        return res[0..<end]
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let term = searchBar.text {
            if let v = dictionary?["Województwa"] as? NSDictionary {
            outerLoop: for k in v.allKeys { //województwa
                if let d = v[k] as? NSDictionary { //województwo
                    if let wyr = d["wyr"] as? [String] {
                        for w in wyr {
                            for a in d.allKeys {
                                if let p = d[a] as? [String] {
                                    for s in p {
                                        if "\(w)\(s)" == term {
                                            selectedVoivodship = k as! String
                                            selectedSelectors = wyr
                                            foundDistrict = a as! String
                                            foundDistrictPlates = d[a] as? NSArray
                                            performSegue(withIdentifier: "segueSearchResults", sender: self)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
                
            }
        }
        searchBar.endEditing(true)
    }
    
}

