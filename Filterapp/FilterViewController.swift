//
//  FilterViewController.swift
//  Filterapp
//
//  Created by 福井彩乃 on 2020/05/22.
//  Copyright © 2020 Fukui Ayanon. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet var cameraImageView: UIImageView!
       
       //画像加工するための元となる画像
       var originalImage: UIImage!
       
       //画像加工するフィルターの宣言
       var filter: CIFilter!

    override func viewDidLoad() {
        super.viewDidLoad()
     }
    
    //表示している画像にフィルターを加工する時のメソッド
       @IBAction func colorFilter(){
           let filterImage: CIImage = CIImage(image: originalImage)!
           
           //フィルターの設定
           filter = CIFilter(name: "CIColorControls")!
           filter.setValue(filterImage, forKey: kCIInputImageKey)
           //彩度の調整
           filter.setValue(1.0, forKey: "inputSaturation")
           //明度の調整
           filter.setValue(0.5, forKey:"inputBrightness")
           //コントラストの調整
           filter.setValue(2.5, forKey: "inputContrast")
           
           let ctx = CIContext(options: nil)
           let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
           cameraImageView.image = UIImage(cgImage: cgImage!)
       }
}
