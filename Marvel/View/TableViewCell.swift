//
//  TableViewCell.swift
//  Marvel
//
//  Created by Jaber Vieira Da Silva Shamali on 02/03/21.
//

import UIKit
import Hero

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var personagemLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        personagemLb.hero.id = "name"
        img.hero.id = "img"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
