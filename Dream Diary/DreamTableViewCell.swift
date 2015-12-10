//
//  DreamTableViewCell.swift
//  Dream Diary
//
//  Created by Felis Perez on 9/30/15.
//
//

import UIKit

class DreamTableViewCell: UITableViewCell {
    
    // MARK: Properties

    @IBOutlet weak var dreamImageView: UIImageView!
    @IBOutlet weak var dreamTitleLabel: UILabel!
    @IBOutlet weak var dreamDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
