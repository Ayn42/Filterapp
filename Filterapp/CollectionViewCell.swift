//
//  CollectionViewCell.swift
//  Filterapp
//
//  Created by 福井彩乃 on 2020/06/10.
//  Copyright © 2020 Fukui Ayanon. All rights reserved.
//

import UIKit
import DKImagePickerController

class MyCustomCell: UICollectionViewCell {
    @IBOutlet weak var cameraImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor)
        let rightConstraint = self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor)
        let topConstraint = self.contentView.topAnchor.constraint(equalTo: self.topAnchor)
        let bottomConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
}

