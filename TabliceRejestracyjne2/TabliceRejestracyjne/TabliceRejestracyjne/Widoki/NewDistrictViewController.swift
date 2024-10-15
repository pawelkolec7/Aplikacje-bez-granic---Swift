//
//  NewDistrictViewController.swift
//  TabliceRejestracyjne
//
//  Created by student on 09/04/2024.
//

import UIKit

class NewDistrictViewController: UIViewController, UITableViewDataSource {
    
    var plates : NSArray?
    var selectors: [String] = []
    private var myPlates: [String] = []
    private var wiki = ""
    var selectedVoivodship = ""
    var selectedSelector = ""

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPlates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = myPlates[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        VoivodshipLabel.text=selectedVoivodship
        SelectorLabel.text=selectedSelector
        // Do any additional setup after loading the view.
        if let pl = plates  {
            for s in selectors {
                for i in 0..<pl.count-1 {
                    myPlates.append("\(s)\(pl[i])")
                }
            }
            wiki = pl[pl.count-1] as! String
        }
    }
    
    @IBOutlet weak var VoivodshipLabel: UILabel!
    
    @IBOutlet weak var SelectorLabel: UILabel!
    
    @IBAction func btnClicked(_ sender: Any) {
        performSegue(withIdentifier: "segueWiki", sender: self)    }
    
    /*
    // MARK: - Navigation

     

     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WikiViewController {
            destination.selectedDistrict = selectedSelector
            destination.selectorsS = selectors
            destination.url = wiki
        }
    }
    
}
