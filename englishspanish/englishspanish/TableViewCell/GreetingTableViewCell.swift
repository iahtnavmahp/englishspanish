//
//  GreetingTableViewCell.swift
//  englishspanish
//
//  Created by Pham Van Thai on 19/06/2021.
//

import UIKit

class GreetingTableViewCell: UITableViewCell {
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var greetingView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
