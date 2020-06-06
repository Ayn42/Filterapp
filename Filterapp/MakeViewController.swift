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

class MakeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet var filterButton : UIButton!
    @IBOutlet var editButton : UIButton!
    
    //画像加工するための元となる画像
    var originalImage: UIImage!
    
    //画像加工するフィルターの宣言
    var filter: CIFilter!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    
    //カメラ、カメラロールを使った時に選択した画像をアプリ内に表示するためのメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        cameraImageView.image = info[.editedImage] as? UIImage
        
        originalImage = cameraImageView.image //カメラで写真撮った後に画像を加工する元画像として記憶しておく
        
        dismiss(animated: true, completion: nil)
        
    }

    
    //カメラロールにある画像を読み込むメソッド
    @IBAction func openAlbum(){
                 
        let pickerController = DKImagePickerController()
        // 選択可能な枚数を20にする
        pickerController.maxSelectableCount = 20
        pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
                                   
        // 選択された画像はassetsに入れて返却されるのでfetchして取り出す
        for asset in assets {
        asset.fetchFullScreenImage(completeBlock: { (image, info) in
        // ここで取り出せる
        self.cameraImageView.image = image
                    })
                }
            }
               self.present(pickerController, animated: true) {}
                performSegueToEdit()
                performsegueToFilter()
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
        
            EditViewController.originalImage = self.cameraImageView.image
            
        }else if segue.identifier == "toFilterViewController"{
            let FilterViewController:  FilterViewController = segue.destination as! FilterViewController
            
            FilterViewController.originalImage = self.cameraImageView.image
        }
    }
}
