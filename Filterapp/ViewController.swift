//
//Masakaz Ozaki
//が送信しました:
//数秒前
//
//  ViewController.swift
//  Filterapp
//
//  Created by 福井彩乃 on 2020/05/19.
//  Copyright © 2020 Fukui Ayanon. All rights reserved.
//
import AVFoundation
import UIKit
class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var isStopped = true
    var playerLooper: NSObject?
    var player: AVQueuePlayer?
    var playerLayer:AVPlayerLayer!
    var queuePlayer: AVQueuePlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playVideo("backgroundimage")
    }
    
    func playVideo(_ filName: String) {
        if let path = Bundle.main.path(forResource: filName, ofType: "mp4") {
            let url =  URL(fileURLWithPath: path)
            let playerItem = AVPlayerItem(url: url as URL)
            player = AVQueuePlayer(items: [playerItem])
            playerLayer = AVPlayerLayer(player: self.player)
            playerLayer.zPosition = -1
            playerLooper = AVPlayerLooper(player: self.player! , templateItem: playerItem)
            playerLayer.videoGravity = .resizeAspectFill
            playerLayer.frame = view.bounds
            view.layer.addSublayer(self.playerLayer!)
            player?.play()
        }
    }
    func loopVideo(_ videoPlayer: AVPlayer) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            videoPlayer.seek(to: .zero)
            videoPlayer.play()
        }
    }
}
