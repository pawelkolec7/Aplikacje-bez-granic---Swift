//
//  WikiViewController.swift
//  TabliceRejestracyjne
//
//  Created by student on 09/04/2024.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {

    var selectedDistrict = ""
    var selectorsS: [String] = []
    var url = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let newUrl = URL(string: url)!
        Wiki.load(NSURLRequest(url: newUrl) as URLRequest)
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var Wiki: WKWebView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
