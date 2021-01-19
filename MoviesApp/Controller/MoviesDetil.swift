//
//  MoviesDetil.swift
//  MoviesApp
//
//  Created by Divo Ayman on 3/3/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import UIKit
import  Kingfisher
import AVFoundation
import MediaPlayer
import AVKit
class MoviesDetil: UIViewController {
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    @IBOutlet weak var artworkUrl100Image: UIImageView!
    var media : MediaRsponse!
    var player: AVPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
       showData()
        
    }
 
    func play(prev: String){
        let url = URL(string: prev)!
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
    func showData( ) {
        let medyaType = media.getType()
        if medyaType == mediaType.tvShow{
            trackNameLabel.text = media.artistName  ?? ""
        } else if medyaType == mediaType.movie || medyaType == mediaType.music{
            trackNameLabel.text = media.trackName ?? ""
        }
        if medyaType == mediaType.music{
            artistNameLabel.text = media.artistName ?? ""
        }
        else if medyaType == mediaType.tvShow || medyaType == mediaType.movie{
            longDescriptionLabel.text = media.longDescription
        }
        let url = URL(string: media.artworkUrl100)
        artworkUrl100Image.kf.setImage(with: url)
    }
    @IBAction func backBtn(_ sender: UIButton) {
        player?.pause()
        let tabBar = UIStoryboard.init(name: Storybords.main, bundle: nil).instantiateViewController(withIdentifier: VCs.tabBar) as! UITabBarController
        self.present(tabBar, animated: true, completion: nil)
    }
}
