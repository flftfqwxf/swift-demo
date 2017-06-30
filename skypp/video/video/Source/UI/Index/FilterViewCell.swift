//
//  FilterViewCell.swift
//  video
//
//  Created by leixianhua on 6/23/17.
//  Copyright © 2017 leixianhua. All rights reserved.
//

import UIKit

class FilterViewCell: UITableViewCell {
    
@IBOutlet weak var filterItem: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        filterItem.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40.0)
//        print(self.frame)
        print(filterItem.frame)
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
