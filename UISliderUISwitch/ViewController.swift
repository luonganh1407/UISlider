//
//  ViewController.swift
//  UISliderUISwitch
//
//  Created by techmaster on 6/7/17.
//  Copyright © 2017 techmaster. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var btn_Play: UIButton!
        var audio = AVAudioPlayer()
        var playing = true
    @IBOutlet weak var sld_Volumee: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        audio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!))
        audio.prepareToPlay()
        addThumImgForSlider()
    }
//set up
    func addThumImgForSlider () {
        sld_Volumee.setThumbImage(UIImage(named: "thumb.png"), for: .normal)
        sld_Volumee.setThumbImage(UIImage(named: "thumbHightLight.png"), for: .highlighted)
    }
//
    @IBAction func action_Play(_ sender: Any) {
        if playing {
        audio.play()
        btn_Play.setImage(UIImage(named: "pause.png"), for: .normal)
        }else {
            audio.pause()
            btn_Play.setImage(UIImage(named: "play.png"), for: .normal)
            
        }; playing = !playing
    }
    
    @IBAction func btn_Volume(_ sender: Any) {
        audio.volume = (sender as AnyObject).value
        
    }

}

