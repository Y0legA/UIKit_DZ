//
//  PlayerViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 24.09.22.
//

import AVFoundation
import UIKit

/// Интерфейс плеера
class PlayerViewController: UIViewController {
    @IBOutlet weak var playSongLabel: UIButton!
    @IBOutlet weak var imageSongLabel: UIImageView!
    @IBOutlet weak var nameSongLabel: UILabel!
    @IBOutlet weak var timeEstimateLabel: UILabel!
    @IBOutlet weak var lenghtSongSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    
    var songs: [Media] = []
    var timeOfSong = ""
    var currentIndex = 0
    
    private var urls: [String] = []
    private var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @IBAction func closeButtonAction(_ sender: UISlider) {
        dismiss(animated: true)
    }
    
    @IBAction func shareButtonAction(_ sender: UISlider) {
    }
    
    /// Прокрутка трека
    @IBAction func lenfthSliderAction(_ sender: UISlider) {
        lenghtSongSlider.addTarget(self, action: #selector(changeLengthAction(sender: )), for: .touchUpInside)
    }
    
    /// Переход к предыдущему треку
    @IBAction func rewindButtonAction(_ sender: UIButton) {
        currentIndex > 0 ? (currentIndex -= 1) : (currentIndex = urls.count - 1)
        configurePlayer()
    }
    
    /// Проигрывание/пауза
    @IBAction func playButtonAction(_ sender: UIButton) {
        let imageName = player.isPlaying ? "play.fill" : "pause.fill"
        playSongLabel.setImage(UIImage(systemName: imageName), for: .normal)
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }
    
    /// Переход к следующему треку
    @IBAction func forwardButtonAction(_ sender: UIButton) {
        currentIndex = (currentIndex + 1 < songs.count) ? currentIndex + 1 : 0
        configurePlayer()
    }
    
    /// Регулировка громкости
    @IBAction func volumeSliderAction(_ sender: UISlider) {
        player.volume = volumeSlider.value
    }
    
    @objc private func changeLengthAction(sender: UISlider) {
           if sender == lenghtSongSlider {
               player.currentTime = TimeInterval(sender.value)
           }
       }
    
    private func configureUI() {
        timeEstimateLabel.text = timeOfSong
        addSongs()
        setParametersOfPlaying()
        configurePlayer()
    }
    
    private func addSongs() {
        songs.forEach {
            guard let path = Bundle.main.path(forResource: $0.song, ofType: "mp3") else { return }
            urls.append(path)
        }
    }
    
    private func setParametersOfPlaying() {
        guard urls.count > 0 else { return }
        do {
            let song = urls[currentIndex]
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: song))
            imageSongLabel.image = UIImage(named: songs[currentIndex].imageName)
            lenghtSongSlider.maximumValue = Float(player.duration)
        } catch {
            print("error")
        }
    }
    
    /// Конфигурирование текущего трека
    private func configurePlayer() {
        setParametersOfPlaying()
        player.play()
        playSongLabel.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        nameSongLabel.text = songs[currentIndex].song
    }
}
