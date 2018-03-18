//
//  HomeViewController.swift
//  OSTSkylark
//
//  Created by Ramana on 17/03/2018.
//  Copyright © 2018 App Tech. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var episodeSetTableView: UITableView!
    private let episodeDataSource = EpisodeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        title = "Home"
        episodeDataSource.addObserver(self)
        episodeDataSource.loadSetData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let episodeDetailsVC = segue.destination as? EpisodeDetailsViewController,
            let selectedIndex = episodeSetTableView?.indexPathForSelectedRow,
            let selectedCell = episodeSetTableView.cellForRow(at: selectedIndex) as? SetViewCell {
            episodeDetailsVC.episode = selectedCell.episode
            episodeDetailsVC.image = selectedCell.imgEpisode.image
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeDataSource.episodesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SetViewCell.self)) as? SetViewCell else {
            return UITableViewCell()
        }
        cell.episodeData = episodeDataSource.episodesData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension HomeViewController: SetObserver {
    func setsChanged() {
        episodeSetTableView.reloadData()
    }
}
