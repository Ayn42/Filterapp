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
    
    private var imageView = UIImage()
    private var ciFilter: CIFilter!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraimageView.image = self.cameraImageView
        title = "露出"

        guard let uiImage = UIImage(named: "sample"), let ciImage = uiImage.ciImage ?? CIImage(image: uiImage) else { return }

        cameraimageView.image = uiImage

        // Filterに合わせた最大値、最小値、初期値の設定
        roshutuSlider.maximumValue = 3
        roshutuSlider.minimumValue = -3
        roshutuSlider.value = 0

        roshutuLabel.text = String(roshutuSlider.value)

        // CIFilterの生成
        ciFilter = CIFilter(name: "CIExposureAdjust")

        // 入力画像の設定
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
        title = "ハイライト"

        guard let _ = UIImage(named: "sample"), let _ = uiImage.ciImage ?? CIImage(image: uiImage) else { return }

        cameraimageView.image = uiImage

        // Filterに合わせた最大値、最小値、初期値の設定
        highlightSlider.maximumValue = 1
        highlightSlider.minimumValue = 0
        highlightSlider.value = 1

        highlightLabel.text = String(highlightSlider.value)

        // CIFilterの生成
        ciFilter = CIFilter(name: "CIHighlightShadowAdjust")

        // 入力画像の設定
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
        
        title = "彩度"

        guard let _ = UIImage(named: "sample"), let _ = uiImage.ciImage ?? CIImage(image: uiImage) else { return }

        cameraimageView.image = uiImage

        // Filterに合わせた最大値、最小値、初期値の設定
        saidoSlider.maximumValue = 2
        saidoSlider.minimumValue = 0
        saidoSlider.value = 1

        saidoLabel.text = String(saidoSlider.value)

        // CIFilterの生成
        ciFilter = CIFilter(name: "CIColorControls")

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
            if let filteredImage = ciFilter.outputImage {
                cameraimageView.image = UIImage(ciImage: filteredImage)
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

