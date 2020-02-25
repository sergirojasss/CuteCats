//
//  CatsCVCell.swift
//  CuteCats
//
//  Created by Sergi Rojas on 24/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import UIKit
import MBProgressHUD

class CatsCVCell: UICollectionViewCell {
    
    @IBOutlet var catImageView: UIImageView!
    
    @IBOutlet var title: UILabel!
    @IBOutlet var numOfViews: UILabel!
    
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
    }
    
    func setLables(cat: Cat) {
        
        self.title.text = cat.title
        self.numOfViews.text = String(cat.views)

    }
    

}
