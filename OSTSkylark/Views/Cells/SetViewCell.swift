//
//  HomeViewCell.swift
//  OSTSkylark
//
//  Created by Ramana on 17/03/2018.
//  Copyright © 2018 App Tech. All rights reserved.
//

import UIKit
import AlamofireImage

final class SetViewCell: UITableViewCell {
    @IBOutlet weak var lblEpisodeTitle: UILabel!
    @IBOutlet weak var lblSynopsis: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var imgEpisode: UIImageView!
    
    var episodeData: EpisodeData? {
        didSet {
            loadEpisode()
        }
    }
    var episode: Episode? {
        didSet {
            setupUI()
        }
    }
    
    var isFavorite = false
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgEpisode.af_cancelImageRequest()
        lblEpisodeTitle.text = ""
        lblSynopsis.text = ""
        imgEpisode.image = UIImage(named: "placeholder")
        imgEpisode.contentMode = .top
        btnFavorite.imageView?.image = UIImage(named: "favorite")
        isFavorite = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblEpisodeTitle.text = ""
        lblSynopsis.text = ""
    }
    
    func setupUI() {
        lblEpisodeTitle.text = episode?.title
        lblSynopsis.text = episode?.synopsis
        if let id = episode?.uid, FavoriteHelper.isFavorite(id) {
            isFavorite = true
        } else {
            isFavorite = false
        }
        updateFavoriteButton()
        if let urlString = episode?.imageUrl, urlString != "", let url = URL(string: urlString) {
            imgEpisode.af_setImage(withURL: url)
            imgEpisode.contentMode = .scaleAspectFill
        } else {
            if let urlString = episode?.imageDataUrl,
                urlString != "" {
                DataService.getImage(urlString: urlString) { [weak self] response in
                    switch response.result {
                    case .success(let imageData):
                        if imageData.imageUrl != "", let url = URL(string: imageData.imageUrl) {
                            self?.imgEpisode.af_setImage(withURL: url)
                            self?.imgEpisode.contentMode = .scaleAspectFill
                            if let episode = self?.episode {
                                DatabaseHelper.shared.updateEpisode(episode, with: imageData.imageUrl)
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    func loadEpisode() {
        guard let data = episodeData else {
            return
        }
        if let episode = DatabaseHelper.shared.getEpisode(with: data.contentUrl) {
            self.episode = episode
        } else {
            DataService.getEpisodes(urlString: data.contentUrl) { [weak self] response in
                switch response.result {
                case .success(let episode):
                    episode.url = data.contentUrl
                    self?.episode = episode
                    DatabaseHelper.shared.addEpisode(episode)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        guard let episode = episode else {
            return
        }
        isFavorite = !isFavorite
        if isFavorite {
            FavoriteHelper.addFavorite(episode.uid)
        } else {
            FavoriteHelper.removeFavorite(episode.uid)
        }
        updateFavoriteButton()
    }
    
    func updateFavoriteButton() {
        if isFavorite {
            btnFavorite.imageView?.image = UIImage(named: "favorite_selected")
        } else {
            btnFavorite.imageView?.image = UIImage(named: "favorite")
        }
    }
}
