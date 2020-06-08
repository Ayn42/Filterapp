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

class EditViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var cameraimageView: UIImageView!
    @IBOutlet weak var roshutuSlider: UISlider!
    @IBOutlet weak var roshutuLabel: UILabel!
    @IBOutlet weak var highlightSlider: UISlider!
    @IBOutlet weak var highlightLabel: UILabel!
    @IBOutlet weak var saidoSlider: UISlider!
    @IBOutlet weak var saidoLabel: UILabel!
    @IBOutlet weak var contrustSlider : UISlider!
    @IBOutlet weak var contrustLabel : UILabel!
    @IBOutlet weak var shadowSlider : UISlider!
    @IBOutlet weak var shadowLabel : UILabel!
    @IBOutlet var collectionView : UICollectionView!
    
    var originalImage : UIImage!
    let images = UIImage(named: "originalImage")
    private var ciFilter: CIFilter!
    private var ciFilter2: CIFilter!
    private var ciFilter3: CIFilter!
    private var ciFilter4: CIFilter!
    private var ciFilter5: CIFilter!
    var context : CIContext!
    var context2 : CIContext!
    var context3 : CIContext!
    var context4 : CIContext!
    var context5 : CIContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         cameraimageView.image = originalImage
        //UICollectionViewFlowLayoutをインスタンス化
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 5, bottom: 15, right: 5)//レイアウトを調整
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
               
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //表示するセルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
              //今回はセルを9個にしてみる
              return 9
       }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
              //表示するCellの登録
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
              //セルの背景色をgrayに
              cell.backgroundColor = .gray

              return cell
          }
       
    //セルの配置について決める
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             let horizontalSpace : CGFloat = 10
             let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
             return CGSize(width: cellSize, height: cellSize)
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
            
        //コントラストのスライダー
        contrustSlider.maximumValue = 1.2
        contrustSlider.minimumValue = 0.8
        contrustSlider.value = 1
            
        // Filterに合わせた最大値、最小値、初期値の設定
        shadowSlider.maximumValue = 1
        shadowSlider.minimumValue = -1
        shadowSlider.value = 0

        //ラベルを表示する
         highlightLabel.text = String(highlightSlider.value)
         roshutuLabel.text = String(roshutuSlider.value)
         saidoLabel.text = String(saidoSlider.value)
         contrustLabel.text = String(contrustSlider.value)
         shadowLabel.text = String(shadowSlider.value)
            
         // CIFilterの生成
         ciFilter = CIFilter(name: "CIHighlightShadowAdjust")
         ciFilter2 = CIFilter(name: "CIExposureAdjust")
         ciFilter3 = CIFilter(name: "CIColorControls")
         ciFilter4 = CIFilter(name:"CIColorControls")
         ciFilter5 = CIFilter(name: "CIHighlightShadowAdjust")
        
         context = CIContext()
         context2 = CIContext()
         context3 = CIContext()
         context4 = CIContext()
         context5 = CIContext()

         // 入力画像の設定
         ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
         ciFilter2.setValue(ciImage, forKey: kCIInputImageKey)
         ciFilter3.setValue(ciImage, forKey: kCIInputImageKey)
         ciFilter4.setValue(ciImage, forKey: kCIInputImageKey)
         ciFilter5.setValue(ciImage, forKey: kCIInputImageKey)
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
    
       @IBAction func valueChanged4(_ sender: UISlider) {
           contrustLabel.text = String(sender.value)

           // コントラストの設定
           ciFilter4.setValue(sender.value, forKey: "inputContrast")

           // Filter適応後の画像を表示
          if let filteredImage = ciFilter4.outputImage {
            
          cameraimageView.image = UIImage(ciImage: filteredImage)
        }
      }
       @IBAction func valueChanged5(_ sender: UISlider) {
            shadowLabel.text = String(sender.value)

            // シャドウの設定
            ciFilter5.setValue(sender.value, forKey: "inputShadowAmount")

            // Filter適応後の画像を表示
            if let filteredImage = ciFilter5.outputImage {
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

