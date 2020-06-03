//
//  FilterViewController.swift
//  Filterapp
//
//  Created by 福井彩乃 on 2020/05/22.
//  Copyright © 2020 Fukui Ayanon. All rights reserved.
//

import UIKit
import Photos
import DKImagePickerController

class FilterViewController: UIViewController {
    
    @IBOutlet var cameraImageView: UIImageView!
       
       //画像加工するための元となる画像
       var originalImage: UIImage!
       
       //画像加工するフィルターの宣言
       var filter: CIFilter!

    override func viewDidLoad() {
        super.viewDidLoad()
         cameraImageView.image = originalImage
     }
    
    //表示している画像にフィルターを加工する時のメソッド
    @IBAction func Filter1(){
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
    @IBAction func Filter2(){
        
       let filterImage: CIImage = CIImage(image: originalImage)!
                 
            //フィルターの設定
            filter = CIFilter(name: "CISepiaTone")!
            filter.setValue(filterImage, forKey: kCIInputImageKey)
            //彩度の調整
            filter.setValue(0.8, forKey: "inputIntensity")
                 
            let ctx = CIContext(options: nil)
            let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
            cameraImageView.image = UIImage(cgImage: cgImage!)
    }
    @IBAction func Filter3(){
        let filterImage: CIImage = CIImage(image: originalImage)!
                 
            //フィルターの設定
            filter = CIFilter(name: "CIColorMonochrome")!
            filter.setValue(filterImage, forKey: kCIInputImageKey)
            //彩度の調整
          filter.setValue(CIColor(red: 0.75, green: 0.75, blue: 0.75), forKey: "inputColor")
            //明度の調整
        filter.setValue(1.0, forKey:"inputIntensity")
           
            
            let ctx = CIContext(options: nil)
            let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
                 cameraImageView.image = UIImage(cgImage: cgImage!)
    }

    
    
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func savePhoto(){
        UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, nil, nil, nil)
    }
}
