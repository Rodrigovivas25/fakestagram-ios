//
//  CommentsTableViewCell.swift
//  fakestagram
//
//  Created by Rodrigo Vivas on 8/5/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
