//
//  MakeViewController.swift
//  Filterapp
//
//  Created by 福井彩乃 on 2020/05/19.
//  Copyright © 2020 Fukui Ayanon. All rights reserved.
//

import UIKit

class MakeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    //カメラ、カメラロールを使った時に選択した画像をアプリ内に表示するためのメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        cameraImageView.image = info[.editedImage] as? UIImage
        
        originalImage = cameraImageView.image //カメラで写真撮った後に画像を加工する元画像として記憶しておく
        
        dismiss(animated: true, completion: nil)
        
    }
    //撮影した画像を保存するためのメソッド
    @IBAction func savePhoto(){
        UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, nil, nil, nil)
    }
    
    //カメラロールにある画像を読み込むメソッド
         @IBAction func openAlbum(){
             //カメラロールを使えるかの確認
             if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                 
                 //カメラロールの画像を選択して画像を表示するまでの一連の流れ
                 let picker = UIImagePickerController()
                 picker.sourceType = .photoLibrary
                 picker.delegate = self
                 
                 picker.allowsEditing = true
                 
                 present(picker, animated: true, completion: nil)
             }
         }
    
}
