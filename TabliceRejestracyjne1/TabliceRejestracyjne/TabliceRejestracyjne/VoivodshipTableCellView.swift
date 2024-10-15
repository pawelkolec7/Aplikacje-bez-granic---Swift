//
//  VoivodshipTableCellView.swift
//  TabliceRejestracyjne
//
//  Created by student on 26/03/2024.
//

import UIKit

class VoivodshipTableCellView: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var labelSelectors: UILabel!
    @IBOutlet weak var labelVoivodship: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
