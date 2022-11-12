//
//  PlayerViewController.swift
//  PickerApp
//
//  Created by Jonathan Kearns on 10/27/22.
//

import UIKit
import AVFoundation



// --------------- 360 ROTATION EXTENSION ---------------

extension UIView {
    func rotate360(duration: CFTimeInterval = 10.0) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = CGFloat.pi * 2
        rotationAnimation.duration = duration
        rotationAnimation.repeatCount = Float.infinity
        self.layer.add(rotationAnimation, forKey: nil)
    }
    
    func stopRotation(){
        self.layer.removeAllAnimations()
    }
}

// --------------- PUBLIC VARIABLES & CONSTANTS ---------------

var audioPlayer = AVAudioPlayer()


// --------------- VIEW CONTROLLER --------------------

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var record: UIView!
    @IBOutlet weak var recordHole: UIView!
    @IBOutlet weak var playPauseButton: UIButton!

    
    
    var podcastAudioFile: String?
    
//    public var position: Int = 0
//    public var episodes: [Episode] = []
//
//    @IBOutlet var holder: UIView!
    
    
//    ------------------- VIEW DID LOAD ---------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        record.backgroundColor = primaryColor
        record.layer.cornerRadius = self.record.frame.height / 2
        record.layer.shadowColor = UIColor.black.cgColor
        record.layer.shadowOpacity = 0.2
        record.layer.shadowOffset = .zero
        record.layer.shadowRadius = 10
        record.layer.shouldRasterize = true
        
        recordHole.layer.cornerRadius = self.recordHole.frame.height / 2
        
        playPauseButton.tintColor = tertiaryColor
        
        
        
            
//      ----- AUDIO PLAYER - GET FILE -----
        let playingPodcast = Bundle.main.path(forResource: podcastAudioFile, ofType: "mp3")
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: playingPodcast!))
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [AVAudioSession.CategoryOptions.duckOthers])
        } catch {
            print(error)
        }
   
    }
    
  
//    ------------------- PLAY / PAUSE BUTTON --------------------
    
    @IBAction func playPauseButtonPressed(_ sender: UIButton) {
        if audioPlayer.isPlaying{
            audioPlayer.stop()
            playPauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            record.stopRotation()

            
        } else {
            audioPlayer.play()
            playPauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            record.rotate360()
            
        }
    }

}
