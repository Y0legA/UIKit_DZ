//
//  ViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 21.09.22.
//

import UIKit

/// Экран списка песен
class PListViewController: UIViewController {
    @IBOutlet weak var nameSongOneLabel: UILabel!
    @IBOutlet weak var nameSongTwoLabel: UILabel!
    @IBOutlet weak var timeLengthFirstSong: UILabel!
    @IBOutlet weak var timeLengthSecondSong: UILabel!
    private let songs: [Media] = [
        Media.init(song: "Let there be cello", imageName: "Let_There_be_cello"),
        Media.init(song: "Celloverse", imageName: "Celloverse")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @IBAction func firstSongAction(_ sender: Any) {
        guard let playerViewController = storyboard?.instantiateViewController(withIdentifier: "playerViewController")
                as? PlayerViewController else { return }
        playerViewController.songs = songs
        playerViewController.timeOfSong = "2:39"
        present(playerViewController, animated: true)
    }
    
    @IBAction func secondSongAction(_ sender: Any) {
        guard let playerViewController = storyboard?.instantiateViewController(withIdentifier: "playerViewController")
                as? PlayerViewController else { return }
        playerViewController.currentIndex = 1
        playerViewController.songs = songs
        playerViewController.timeOfSong = "4:09"
        present(playerViewController, animated: true)
    }
    
    private func configureUI() {
        timeLengthFirstSong.text = "2:39"
        timeLengthSecondSong.text = "4:09"
        nameSongOneLabel.text = songs[0].song
        nameSongTwoLabel.text = songs[1].song
    }
}
