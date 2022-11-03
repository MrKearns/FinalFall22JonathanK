//
//  TableViewCell.swift
//  PickerApp
//
//  Created by Jonathan Kearns on 10/27/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    
//    --------------- CELL VARIABLES DETAILS ---------------
    
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var episodeNumber: UILabel!
    @IBOutlet weak var episodeDate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
