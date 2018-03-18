//
//  EpisodeDetailsViewController.swift
//  OSTSkylark
//
//  Created by Ramana on 17/03/2018.
//  Copyright © 2018 App Tech. All rights reserved.
//

import UIKit

final class EpisodeDetailsViewController: UIViewController {
    
    @IBOutlet weak var imgEpisode: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtSynopsis: UITextView!
    
    var episode: Episode?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        title = "Episode Details"
        lblTitle.text = episode?.title
        txtSynopsis.text = episode?.synopsis
        if image != nil {
            imgEpisode.image = image
        }
    }
}
