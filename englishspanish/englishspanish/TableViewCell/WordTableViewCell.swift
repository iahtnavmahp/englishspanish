//
//  WordTableViewCell.swift
//  englishspanish
//
//  Created by Pham Van Thai on 07/05/2021.
//

import UIKit

class WordTableViewCell: UITableViewCell {
    //icons8-heart-100
    @IBOutlet weak var myButton: UIButton!
    
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
