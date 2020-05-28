//
//  EditViewController.swift
//  Filterapp
//
//  Created by 福井彩乃 on 2020/05/21.
//  Copyright © 2020 Fukui Ayanon. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var cameraimageView: UIImageView!
    @IBOutlet weak var roshutuSlider: UISlider!
    @IBOutlet weak var roshutuLabel: UILabel!
    @IBOutlet weak var highlightSlider: UISlider!
    @IBOutlet weak var highlightLabel: UILabel!
    @IBOutlet weak var saidoSlider: UISlider!
    @IBOutlet weak var saidoLabel: UILabel!
    
    var originalImage : UIImage!
    private var ciFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraimageView.image = originalImage
        
        title = "ハイライト"

        guard let uiImage = UIImage(named: "originalImage"), let ciImage = originalImage ?? CIImage(image: uiImage) else { return }

        cameraimageView.image = originalImage

        // Filterに合わせた最大値、最小値、初期値の設定
        highlightSlider.maximumValue = 1
        highlightSlider.minimumValue = 0
        highlightSlider.value = 1

        highlightLabel.text = String(highlightSlider.value)

        // CIFilterの生成
        ciFilter = CIFilter(name: "CIHighlightShadowAdjust")

        // 入力画像の設定
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
    }

    @IBAction func valueChanged(_ sender: UISlider) {
        roshutuLabel.text = String(sender.value)

        // 露出の設定
        ciFilter.setValue(sender.value, forKey: "inputEV")

        // Filter適応後の画像を表示
        if let filteredImage = ciFilter.outputImage {
            cameraimageView.image = UIImage(ciImage: filteredImage)
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
           ciFilter.setValue(sender.value, forKey: "inputSaturation")

           // Filter適応後の画像を表示
           if let filteredImage = ciFilter.outputImage {
               
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

