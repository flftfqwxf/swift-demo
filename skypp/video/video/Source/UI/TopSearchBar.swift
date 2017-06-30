//
//  TopSearchBar.swift
//  video
//
//  Created by leixianhua on 6/19/17.
//  Copyright © 2017 leixianhua. All rights reserved.
//

import UIKit

class TopSearchBar: UISearchBar {

    
    var searchTF:UITextField!
    
     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.commonInit()
    }
    
    func commonInit() {
        
        
        
        self.layer.cornerRadius = 14
        self.layer.masksToBounds = true
//        dump(self)
        self.backgroundImage = UIImage.imageWithColor(UIColor(r: 88, g: 88, b: 88))
        let placeholderAttributes: [String : AnyObject] = [NSForegroundColorAttributeName: UIColor.green, NSFontAttributeName: UIFont.systemFont(ofSize: UIFont.systemFontSize)]

        let attributedPlaceholder: NSAttributedString = NSAttributedString(string: "Search", attributes: placeholderAttributes)

        searchTF = self.value(forKey: "searchField") as? UITextField
        if let tf = searchTF {
            tf.tintColor = UIColor.red
            tf.backgroundColor = UIColor.clear
            tf.textColor = UIColor.blue
            tf.attributedPlaceholder=attributedPlaceholder
            if let glassIcon = tf.leftView as? UIImageView {
                glassIcon.image = glassIcon.image?.withRenderingMode(.alwaysTemplate)
                glassIcon.tintColor = kThemeColorOrange
            }
        }
    }

}
