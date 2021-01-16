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
    
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    @IBOutlet private weak var sepiaButton: UIButton! {
        didSet {
            sepiaButton.layer.borderWidth = 1
            sepiaButton.layer.borderColor = UIColor.black.cgColor
        }
    }

    @IBOutlet private weak var brightButton: UIButton! {
        didSet {
            brightButton.layer.borderWidth = 1
            brightButton.layer.borderColor = UIColor.black.cgColor
        }
    }

    @IBOutlet private weak var bwButton: UIButton! {
        didSet {
            bwButton.layer.borderWidth = 1
            bwButton.layer.borderColor = UIColor.black.cgColor
        }
    }

    private let reuseIdentifier = "Cell"
    
    var imageArray: [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UICollectionViewFlowLayoutをインスタンス化
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 5, bottom: 15, right: 5)//レイアウトを調整
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
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
        print("filter1 pressed")
        
        for i in 0..<imageArray.count {
            //実行されるコード
            let filterImage: CIImage = CIImage(image: imageArray[i])!

            let filter = CIFilter(name: "CIColorControls")!
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
        collectionView.reloadData()
    }
    
    @IBAction func Filter2(){
        print("filter2 pressed")
        for i in 0..<imageArray.count{
            //実行されるコード
            let filterImage: CIImage = CIImage(image: imageArray[i])!
            let filter = CIFilter(name: "CISepiaTone")!
            filter.setValue(filterImage, forKey: kCIInputImageKey)
            //彩度の調整
            filter.setValue(0.8, forKey: "inputIntensity")
            let ctx = CIContext(options: nil)
            let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
            imageArray[i] = UIImage(cgImage : cgImage!)
            (collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! MyCustomCell).cameraImageView.image  = UIImage(ciImage: filterImage)
        }
        collectionView.reloadData()
    }
    
    @IBAction func Filter3(){
        print("filter3 pressed")
        for i in 0..<imageArray.count{
            //実行されるコード
            let filterImage: CIImage = CIImage(image: imageArray[i])!
            let filter = CIFilter(name: "CIColorMonochrome")!
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
        collectionView.reloadData()
    }

    @IBAction func savePhoto(){
        for i in 0..<imageArray.count{
            UIImageWriteToSavedPhotosAlbum(imageArray[i], nil, nil, nil)
        }
        let alert = UIAlertController(title: "画像を保存しました", message: "画像はカメラロールに保存されました", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

