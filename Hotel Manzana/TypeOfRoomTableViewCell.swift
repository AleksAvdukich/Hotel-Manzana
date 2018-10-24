//
//  TypeOfRoomTableViewCell.swift
//  Hotel Manzana
//
//  Created by Aleksandr Avdukich on 24/10/2018.
//  Copyright © 2018 Sanel Avdukich. All rights reserved.
//

import UIKit

class TypeOfRoomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var shortNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
