//
//  CollectionViewController.swift
//  Filterapp
//
//  Created by 福井彩乃 on 2020/06/11.
//  Copyright © 2020 Fukui Ayanon. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    var imageArray : [Dictionary<String, String>] = []
    let saveData = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

    }

    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        if saveData.array(forKey: "Image") != nil{
            imageArray = saveData.array(forKey: "Image")as![Dictionary<String,String>]
        }
        collectionView.reloadData()
    }

    //セクション数を指定します
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

   //セルの個数を指定します
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    //セルの中身の表示の仕方を変更します
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        //let nowIndexPath = imageArray[indexPath.row]

        return cell
    }
}
