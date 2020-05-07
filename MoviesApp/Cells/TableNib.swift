//
//  TableViewCell.swift
//  MoviesApp
//
//  Created by Divo Ayman on 2/25/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import UIKit
import Kingfisher
import SQLite
class TableNib: UITableViewCell {
    @IBOutlet weak var longDescLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artImageUrl: UIImageView!
    var myMedia = [MediaRsponse]( )
    var dataBase = SQLiteManager( )
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(media: MediaRsponse) {
        let medyaType = media.getType()
        if medyaType == mediaType.tvShow{
            nameLabel.text = media.artistName  ?? ""
        } else if medyaType == mediaType.movie || medyaType == mediaType.music{
            nameLabel.text = media.artistName ?? ""
        }
        if medyaType == mediaType.music{
            longDescLabel.text = media.trackName ?? ""
        }
        else if medyaType == mediaType.tvShow || medyaType == mediaType.movie{
            longDescLabel.text = media.longDescription
        }
        let url = URL(string: media.artworkUrl100)
        artImageUrl.kf.setImage(with: url)
        SQLiteManager.insertTable(artistName: media.artistName ?? "e", artworkUrl100: media.artworkUrl100, trackName: media.trackName ?? "e", longDescription: media.longDescription ?? "e", previewUrl: media.previewUrl ?? "d", kind: media.Kind ?? "h")
    }
}

