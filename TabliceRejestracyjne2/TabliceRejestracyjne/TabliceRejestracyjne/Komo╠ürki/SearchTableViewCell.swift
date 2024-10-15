//
//  SearchTableViewCell.swift
//  TabliceRejestracyjne
//
//  Created by Bartłomiej Prędki on 24/10/2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var searchBar: UISearchBar!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
