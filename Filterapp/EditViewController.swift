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
    
    //@IBOutlet weak var cameraimageView: UIImageView!
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
    private let reuseIdentifier = "Cell"
    
    //var originalImage : UIImage!
    //let images = UIImage(named: "originalImage")
    var imageArray : [UIImage] = [UIImage]()
    var ciImage : [CIImage] = [CIImage]()
    var highlightFilter: [CIFilter] = [CIFilter]() //私はFilterで配列を作りました
    var roshutuFilter : [CIFilter] = [CIFilter]()
    var saidoFilter : [CIFilter] = [CIFilter]()
    var shadowFilter : [CIFilter] = [CIFilter]()
    var contrustFilter : [CIFilter] = [CIFilter]()
    let images = UIImage(named: "imageArray")

    
    //private var ciFilter: CIFilter!
    //private var ciFilter2: CIFilter!
    //private var ciFilter3: CIFilter!
    //private var ciFilter4: CIFilter!
    //private var ciFilter5: CIFilter!
    //private var ciFilter6: CIFilter!
    //private var ciFilter7: CIFilter!
    //private var ciFilter8: CIFilter!
    //private var ciFilter9: CIFilter!
    var context : CIContext!
    var context2 : CIContext!
    var context3 : CIContext!
    var context4 : CIContext!
    var context5 : CIContext!
    var context6 : CIContext!
    var context7 : CIContext!
    var context8 : CIContext!
    var context9 : CIContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //表示するCellの登録
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCustomCell
        
        cell.cameraImageView.image = imageArray[indexPath.row]
        
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
        
        //全ての画像をciImageに変換する
        for i in 0..<imageArray.count{
            guard let ciImage = imageArray[i].ciImage ?? CIImage(image: imageArray[i]) else{return}
            //CIFilterの生成
            highlightFilter.append( CIFilter(name: "CIHighlightShadowAdjust")!)
            roshutuFilter.append( CIFilter(name: "CIExposureAdjust")!)
            contrustFilter.append( CIFilter(name: "CIColorControls")!)
            saidoFilter.append( CIFilter(name: "CIColorControls")!)
            shadowFilter.append( CIFilter(name: "CIHighlightShadowAdjust")!)
            
             //入力画像の設定
            highlightFilter[i].setValue(ciImage, forKey: kCIInputImageKey)
            saidoFilter[i].setValue(ciImage, forKey: kCIInputImageKey)
            contrustFilter[i].setValue(ciImage, forKey: kCIInputImageKey)
            roshutuFilter[i].setValue(ciImage, forKey: kCIInputImageKey)
            shadowFilter[i].setValue(ciImage, forKey: kCIInputImageKey)
            
  }
        
        //guard let ciImage2 = imageArray[1].ciImage ?? CIImage(image: imageArray[1]) else{return}
        //guard let ciImage3 = imageArray[2].ciImage ?? CIImage(image: imageArray[2]) else{return}
        //guard let ciImage4 = imageArray[3].ciImage ?? CIImage(image: imageArray[3]) else{return}
        //guard let ciImage5 = imageArray[4].ciImage ?? CIImage(image: imageArray[4]) else{return}
        //guard let ciImage6 = imageArray[5].ciImage ?? CIImage(image: imageArray[5]) else{return}
        //guard let ciImage7 = imageArray[6].ciImage ?? CIImage(image: imageArray[6]) else{return}
        //guard let ciImage8 = imageArray[7].ciImage ?? CIImage(image: imageArray[7]) else{return}
        //guard let ciImage9 = imageArray[8].ciImage ?? CIImage(image: imageArray[8]) else{return}
        
        //guard let ciImage = uiImage.ciImage ?? CIImage(image: uiImage) else { return }
        
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
        //ciFilter = CIFilter(name: "CIHighlightShadowAdjust")
        //ciFilter2 = CIFilter(name: "CIExposureAdjust")
        //ciFilter3 = CIFilter(name: "CIColorControls")
        //ciFilter4 = CIFilter(name: "CIHighlightShadowAdjust")
        //ciFilter5 = CIFilter(name:"CIColorControls")
        //ciFilter6 = CIFilter(name: "CIHighlightShadowAdjust")
        //ciFilter7 = CIFilter(name: "CIExposureAdjust")
        //ciFilter8 = CIFilter(name: "CIColorControls")
        //ciFilter9 = CIFilter(name: "CIHighlightShadowAdjust")
        
        context = CIContext()
        context2 = CIContext()
        context3 = CIContext()
        context4 = CIContext()
        context5 = CIContext()
        context6 = CIContext()
        context7 = CIContext()
        context8 = CIContext()
        context9 = CIContext()
        
        // 入力画像の設定
        //highlightFilter.setValue(ciImageArray, forKey: kCIInputImageKey)
        //saidoFilter.setValue(ciImageArray, forKey: kCIInputImageKey)
        //contrustFilter.setValue(ciImageArray, forKey: kCIInputImageKey)
        //roshutuFilter.setValue(ciImageArray, forKey: kCIInputImageKey)
    }
    
    @IBAction func valueChanged(_ sender: UISlider) {
        
        for i in 0..<imageArray.count{
        roshutuLabel.text = String(sender.value)
        // 露出の設定
        roshutuFilter[i].setValue(sender.value, forKey: "inputEV")
        if let filteredImage = roshutuFilter[i].outputImage {
            imageArray[i] = UIImage(ciImage: filteredImage)
            }
        }
    }
        // Filter適応後の画像を表示
//        if let originalImage = ciFilter2.outputImage {
//            (collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: originalImage)
//            (collectionView.cellForItem(at: IndexPath(item: 1, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: originalImage)
//            (collectionView.cellForItem(at: IndexPath(item: 2, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: originalImage)
//            (collectionView.cellForItem(at: IndexPath(item: 3, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: originalImage)
//            (collectionView.cellForItem(at: IndexPath(item: 4, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: originalImage)
//            (collectionView.cellForItem(at: IndexPath(item: 5, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: originalImage)
//            (collectionView.cellForItem(at: IndexPath(item: 6, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: originalImage)
//            (collectionView.cellForItem(at: IndexPath(item: 7, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: originalImage)
//            (collectionView.cellForItem(at: IndexPath(item: 8, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: originalImage)}}
    
    @IBAction func valueChanged2(_ sender: UISlider) {
        //highlightLabel.text = String(sender.value)
        
        // ハイライトの設定
        for i in 0..<imageArray.count{
            highlightLabel.text = String(sender.value)
            highlightFilter[i].setValue(sender.value, forKey: "inputHighlightAmount")
            if let filteredImage = highlightFilter[i].outputImage {
             imageArray[i] = UIImage(ciImage: filteredImage)
            }
        }
    }

    
    @IBAction func valueChanged3(_ sender: UISlider) {
        for i in 0..<imageArray.count{
        saidoLabel.text = String(sender.value)
        // 彩度の設定
        saidoFilter[i].setValue(sender.value, forKey: "inputSaturation")
        if let filteredImage = saidoFilter[i].outputImage {
                imageArray[i] = UIImage(ciImage: filteredImage)
            }
        }
    }
//        // Filter適応後の画像を表示
//        if let filteredImage = ciFilter3.outputImage {
//            (collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage )
//            (collectionView.cellForItem(at: IndexPath(item: 1, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 2, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 3, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 4, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 5, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 6, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 7, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 8, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)}
            
    
    @IBAction func valueChanged4(_ sender: UISlider) {
        for i in 0..<imageArray.count{
        contrustLabel.text = String(sender.value)
        // コントラストの設定
        contrustFilter[i].setValue(sender.value, forKey: "inputContrast")
        if let filteredImage = contrustFilter[i].outputImage {
        imageArray[i] = UIImage(ciImage: filteredImage)
            }
        }
    }
//        // Filter適応後の画像を表示
//        if let filteredImage = ciFilter4.outputImage {
//
//            (collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage )
//            (collectionView.cellForItem(at: IndexPath(item: 1, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 2, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 3, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 4, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 5, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 6, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 7, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 8, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//
//        }

    @IBAction func valueChanged5(_ sender: UISlider) {
        for i in 0..<imageArray.count{
        shadowLabel.text = String(sender.value)
        // シャドウの設定
        shadowFilter[i].setValue(sender.value, forKey: "inputShadowAmount")
        if let filteredImage = shadowFilter[i].outputImage {
        imageArray[i] = UIImage(ciImage: filteredImage)
        }
      }
    }
//        // Filter適応後の画像を表示
//        if let filteredImage = ciFilter5.outputImage {
//            (collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage )
//            (collectionView.cellForItem(at: IndexPath(item: 1, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 2, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 3, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 4, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 5, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 6, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 7, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//            (collectionView.cellForItem(at: IndexPath(item: 8, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
//
//        }
    
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePhoto(){
        for i in 0..<imageArray.count{
            UIImageWriteToSavedPhotosAlbum(imageArray[i], nil, nil, nil)
        }
    }
    // 保存結果をアラートで表示する
    func showResultOfSaveImage(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        
        var title = "保存完了"
        var message = "カメラロールに保存しました"
        
        if error != nil {
            title = "エラー"
            message = "保存に失敗しました"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // OKボタンを追加
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // UIAlertController を表示
        self.present(alert, animated: true, completion: nil)
    }
}
