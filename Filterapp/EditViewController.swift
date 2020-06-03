//
//  EditViewController.swift
//  Filterapp
//
//  Created by 福井彩乃 on 2020/05/21.
//  Copyright © 2020 Fukui Ayanon. All rights reserved.
//

import UIKit
import CoreImage
import Photos
import DKImagePickerController

class EditViewController: UIViewController {

    @IBOutlet weak var cameraimageView: UIImageView!
    @IBOutlet weak var roshutuSlider: UISlider!
    @IBOutlet weak var roshutuLabel: UILabel!
    @IBOutlet weak var highlightSlider: UISlider!
    @IBOutlet weak var highlightLabel: UILabel!
    @IBOutlet weak var saidoSlider: UISlider!
    @IBOutlet weak var saidoLabel: UILabel!
    
    var originalImage : UIImage!
    let images = UIImage(named: "originalImage")
    private var ciFilter: CIFilter!
    private var ciFilter2: CIFilter!
    private var ciFilter3: CIFilter!
    var context : CIContext!
    var context2 : CIContext!
    var context3 : CIContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         cameraimageView.image = originalImage
    }
    //画面表示された直後に呼び出される、毎回呼び出される
        override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            
        guard let ciImage = originalImage.ciImage ?? CIImage(image: originalImage) else { return }
            
        cameraimageView.image = originalImage

         //ハイライトのスライダー
         highlightSlider.maximumValue = 1
         highlightSlider.minimumValue = 0
         highlightSlider.value = 1
            
        //露出のスライダー
        roshutuSlider.maximumValue = 3
        roshutuSlider.minimumValue = -3
        roshutuSlider.value = 0
            
        //彩度のスライダー
        saidoSlider.maximumValue = 2
        saidoSlider.minimumValue = 0
        saidoSlider.value = 1


         highlightLabel.text = String(highlightSlider.value)
         roshutuLabel.text = String(roshutuSlider.value)
         saidoLabel.text = String(saidoSlider.value)
            
         // CIFilterの生成
         ciFilter = CIFilter(name: "CIHighlightShadowAdjust")
         ciFilter2 = CIFilter(name: "CIExposureAdjust")
         ciFilter3 = CIFilter(name: "CIColorControls")
        
         context = CIContext()
         context2 = CIContext()
         context3 = CIContext()

         // 入力画像の設定
         ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
         ciFilter2.setValue(ciImage, forKey: kCIInputImageKey)
         ciFilter3.setValue(ciImage, forKey: kCIInputImageKey)
     }
    
    @IBAction func valueChanged(_ sender: UISlider) {
        
        roshutuLabel.text = String(sender.value)

        // 露出の設定
        ciFilter2.setValue(sender.value, forKey: "inputEV")

        // Filter適応後の画像を表示
        if let originalImage = ciFilter2.outputImage {
            cameraimageView.image = UIImage(ciImage: originalImage)
        }
    }
    
     @IBAction func valueChanged2(_ sender: UISlider) {
        
                highlightLabel.text = String(sender.value)

                // ハイライトの設定
      ciFilter.setValue(sender.value, forKey: "inputHighlightAmount")

                // Filter適応後の画像を表示
                if let originalImage = ciFilter.outputImage {
                    cameraimageView.image = UIImage(ciImage: originalImage)
                }
            }
    

    @IBAction func valueChanged3(_ sender: UISlider) {
            saidoLabel.text = String(sender.value)

            // 彩度の設定
            ciFilter3.setValue(sender.value, forKey: "inputSaturation")

            // Filter適応後の画像を表示
            if let filteredImage = ciFilter3.outputImage {
                
            cameraimageView.image = UIImage(ciImage: filteredImage)
           }
        }
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func savePhoto(){
        UIImageWriteToSavedPhotosAlbum(cameraimageView.image!, nil, nil, nil)
    }
}

