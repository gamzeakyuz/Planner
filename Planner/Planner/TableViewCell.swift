
//
//  TableViewCell.swift
//  Planner
//
//  Created by Gamze Akyüz on 20.04.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var examTitle: UILabel!
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var examLocationTitle: UILabel!
    @IBOutlet weak var examSubjectTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
