//
//  MakeViewController.swift
//  Filterapp
//
//  Created by 福井彩乃 on 2020/05/19.
//  Copyright © 2020 Fukui Ayanon. All rights reserved.
//

import UIKit
import Photos
import DKImagePickerController

class MakeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //@IBOutlet var cameraImageView : UIImageView!
    @IBOutlet var filterButton : UIButton!
    @IBOutlet var editButton : UIButton!
    @IBOutlet var collectionView : UICollectionView!
    private let reuseIdentifier = "Cell"
    
    var imageArray : [UIImage] = [UIImage]()
    let saveData = UserDefaults.standard

    //画像加工するための元となる画像
    var originalImage: UIImage!
    //画像加工するフィルターの宣言
    var filter: CIFilter!

    override func viewDidLoad() {
        super.viewDidLoad()

        //imageArrayに写真を入れていく
        imageArray = [UIImage]()
        
        //UICollectionViewFlowLayoutをインスタンス化
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 5, bottom: 15, right: 5)//レイアウトを調整
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
   override  func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        if saveData.array(forKey: "Image") != nil{
            imageArray = saveData.array(forKey: "Image")as![UIImage]
        }
        collectionView.reloadData()
    }
    //セクション数を指定します
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
    
    //セルの個数を指定します
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return imageArray.count
    }
    //セルの中身の表示の仕方を設定します
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           //表示するCellの登録
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCustomCell
        
       // let nowIndexPathDictionary = imageArray[indexPath.row]
           
           //セルの背景色をgrayに
           //cell.backgroundColor = .gray

          //cell.cameraImageView.image = originalImage
        
          cell.cameraImageView.image = imageArray[indexPath.row]
        
           return cell
       }
    
    //セルの配置について決める
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let horizontalSpace : CGFloat = 10
          let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
          return CGSize(width: cellSize, height: cellSize)
      }

    //カメラロールにある画像を読み込むメソッド
    @IBAction func openAlbum(){
                 
        let MyCustomCell = DKImagePickerController()
        // 選択可能な枚数を9にする
        MyCustomCell.maxSelectableCount = 9
        MyCustomCell.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
                                   
        // 選択された画像はassetsに入れて返却されるのでfetchして取り出す
        for asset in assets {
        asset.fetchFullScreenImage(completeBlock: { (image, info) in
        // ここで取り出せる
        //self.cameraImageView.image = image
            
                    })
                }
            }
               self.present(MyCustomCell, animated: true) {}
             }
    
    func performSegueToEdit(){
        performSegue(withIdentifier: "toEditViewController", sender: nil)
    }
    func performsegueToFilter(){
        performSegue(withIdentifier: "toFilterViewController", sender: nil)
    }
    
    @IBAction func back(){
          self.dismiss(animated: true, completion: nil)
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toEditViewController"{
            let EditViewController:  EditViewController = segue.destination as! EditViewController
        
            //EditViewController.originalImage = self.cameraImageView.image
            
        }else if segue.identifier == "toFilterViewController"{
            let FilterViewController:  FilterViewController = segue.destination as! FilterViewController
            
            //FilterViewController.originalImage = self.cameraImageView.image
        }
    }
}
