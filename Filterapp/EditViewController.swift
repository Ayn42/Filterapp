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
    
    var imageArray : [UIImage] = [UIImage]()
    var ciImage : [CIImage] = [CIImage]()
    var highlightFilter: [CIFilter] = [CIFilter]() //Filterで配列を作る
    var roshutuFilter : [CIFilter] = [CIFilter]()
    var saidoFilter : [CIFilter] = [CIFilter]()
    var shadowFilter : [CIFilter] = [CIFilter]()
    var contrustFilter : [CIFilter] = [CIFilter]()
    let images = UIImage(named: "imageArray")

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
  
        //ハイライトのスライダー
        highlightSlider.maximumValue = 1
        highlightSlider.minimumValue = 0
        highlightSlider.value = 0.5
        
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
        
        context = CIContext()
        context2 = CIContext()
        context3 = CIContext()
        context4 = CIContext()
        context5 = CIContext()
        context6 = CIContext()
        context7 = CIContext()
        context8 = CIContext()
        context9 = CIContext()
        
    }
    
    @IBAction func valueChanged(_ sender: UISlider) {
        
        for i in 0..<imageArray.count{
        roshutuLabel.text = String(format: "%.1f", sender.value)
        // 露出の設定
        roshutuFilter[i].setValue(sender.value, forKey: "inputEV")
            
        if let filteredImage = roshutuFilter[i].outputImage {
            let ctx = CIContext(options: nil)
            let cgImage = ctx.createCGImage(roshutuFilter[i].outputImage!, from: roshutuFilter[i].outputImage!.extent)
            imageArray[i] = UIImage(cgImage : cgImage!)
            (collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
            }
        }
    }
    
    @IBAction func valueChanged2(_ sender: UISlider) {
        
        // ハイライトの設定
        for i in 0..<imageArray.count{
            highlightLabel.text = String(format: "%.1f", sender.value)
            highlightFilter[i].setValue(sender.value, forKey: "inputHighlightAmount")
            if let filteredImage = highlightFilter[i].outputImage {
            let ctx = CIContext(options: nil)
            let cgImage = ctx.createCGImage(highlightFilter[i].outputImage!, from: highlightFilter[i].outputImage!.extent)
            imageArray[i] = UIImage(cgImage : cgImage!)
            (collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
            }
        }
    }

    
    @IBAction func valueChanged3(_ sender: UISlider) {
        for i in 0..<imageArray.count{
        saidoLabel.text = String(format: "%.1f", sender.value)
        // 彩度の設定
        saidoFilter[i].setValue(sender.value, forKey: "inputSaturation")
        if let filteredImage = saidoFilter[i].outputImage {
           let ctx = CIContext(options: nil)
           let cgImage = ctx.createCGImage(saidoFilter[i].outputImage!, from: saidoFilter[i].outputImage!.extent)
           imageArray[i] = UIImage(cgImage : cgImage!)
                (collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
            }
        }
    }
    
    @IBAction func valueChanged4(_ sender: UISlider) {
        for i in 0..<imageArray.count{
        contrustLabel.text = String(format: "%.1f", sender.value)
        // コントラストの設定
        contrustFilter[i].setValue(sender.value, forKey: "inputContrast")
        if let filteredImage = contrustFilter[i].outputImage {
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(contrustFilter[i].outputImage!, from: contrustFilter[i].outputImage!.extent)
        imageArray[i] = UIImage(cgImage : cgImage!)
        (collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
            }
        }
    }

    @IBAction func valueChanged5(_ sender: UISlider) {
        for i in 0..<imageArray.count{
        shadowLabel.text = String(format: "%.1f", sender.value)
        // シャドウの設定
        shadowFilter[i].setValue(sender.value, forKey: "inputShadowAmount")
        if let filteredImage = shadowFilter[i].outputImage {
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(shadowFilter[i].outputImage!, from: shadowFilter[i].outputImage!.extent)
        imageArray[i] = UIImage(cgImage : cgImage!)
        (collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filteredImage)
        }
      }
    }
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePhoto(){
           for i in 0..<imageArray.count{
            UIImageWriteToSavedPhotosAlbum(imageArray[i], nil, nil, nil)
          }
       }
}
