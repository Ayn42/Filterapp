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

class FilterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView : UICollectionView!
    private let reuseIdentifier = "Cell"
    
       var imageArray : [UIImage] = [UIImage]()
       
       //画像加工するフィルターの宣言
       var filter: CIFilter!

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
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)as! MyCustomCell
           cell.cameraImageView.image = imageArray[indexPath.row]

           return cell
       }
    
    //セルの配置について決める
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let horizontalSpace : CGFloat = 10
          let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
          return CGSize(width: cellSize, height: cellSize)
      }
    
    //表示している画像にフィルターを加工する時のメソッド
    @IBAction func Filter1(){
        
        for i in 0..<imageArray.count{
            //実行されるコード
            let filterImage: CIImage = CIImage(image: imageArray[i])!
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
            imageArray[i] = UIImage(cgImage : cgImage!)
            (collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filterImage)
        }
    }
    
    @IBAction func Filter2(){
        
        for i in 0..<imageArray.count{
            //実行されるコード
            let filterImage: CIImage = CIImage(image: imageArray[i])!
            filter = CIFilter(name: "CISepiaTone")!
            filter.setValue(filterImage, forKey: kCIInputImageKey)
            //彩度の調整
            filter.setValue(0.8, forKey: "inputIntensity")
            let ctx = CIContext(options: nil)
            let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
            imageArray[i] = UIImage(cgImage : cgImage!)
            (collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filterImage)
            }
        }
    
    @IBAction func Filter3(){
        for i in 0..<imageArray.count{
            //実行されるコード
            let filterImage: CIImage = CIImage(image: imageArray[i])!
           filter = CIFilter(name: "CIColorMonochrome")!
           filter.setValue(filterImage, forKey: kCIInputImageKey)
            //彩度の調整
            filter.setValue(CIColor(red: 0.75, green: 0.75, blue: 0.75), forKey: "inputColor")
            //明度の調整
            filter.setValue(1.0, forKey:"inputIntensity")
            let ctx = CIContext(options: nil)
            let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
            imageArray[i] = UIImage(cgImage : cgImage!)
            (collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filterImage)
      
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

