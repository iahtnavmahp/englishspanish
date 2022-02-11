//
//  AlphabetCollectionViewCell.swift
//  englishspanish
//
//  Created by Pham Van Thai on 19/06/2021.
//

import UIKit

class AlphabetCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    static let identifier = "AlphabetCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func nib() -> UINib{
        return UINib(nibName: "AlphabetCollectionViewCell", bundle: nil)
    }
}
