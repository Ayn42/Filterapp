//
//  CollectionViewCell.swift
//  Filterapp
//
//  Created by 福井彩乃 on 2020/06/10.
//  Copyright © 2020 Fukui Ayanon. All rights reserved.
//

import UIKit
import DKImagePickerController

class MyCustomCell: UICollectionViewCell, UIImagePickerControllerDelegate {
    @IBOutlet weak var cameraImageView: UIImageView!
    var originalImage: UIImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //override func setSelected(_ selected:Bool, animated: Bool){
        //super.setSelected(selected, animated: animated)}
}

