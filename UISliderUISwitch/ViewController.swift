//
//  ViewController.swift
//  UISliderUISwitch
//
//  Created by techmaster on 6/7/17.
//  Copyright © 2017 techmaster. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController ,AVAudioPlayerDelegate {
    @IBOutlet weak var lbl_timeleft: UILabel!
    @IBOutlet weak var btn_Play: UIButton!
        var audio = AVAudioPlayer()
        var playing = true
        var time =  Timer()
    @IBOutlet weak var sld_Volumee: UISlider!
    @IBOutlet weak var sld_duration: UISlider!
    @IBOutlet weak var lbl_timetotal: UILabel!
    @IBOutlet weak var check: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        addThumImgForSlider()
        
    }
//xet thoi gian
    func updateTime(){
//thoi gian bat dau        
        let timeleft = Int(audio.currentTime)
//so phut
        let min = timeleft / 60
//so giay
        let sec = timeleft - min * 60
        lbl_timeleft.text = String(format: "%2d:%02d", min, sec)
        
        self.sld_duration.value = Float(audio.currentTime/audio.duration)
//xet tong time mp3
        let totaltime = Int(audio.duration)
        let minTotal = totaltime/60
        let secTotal = totaltime - minTotal * 60
        lbl_timetotal.text = String(format: "%2d:%02d", minTotal, secTotal)

    }
    
    func addThumImgForSlider () {
        sld_Volumee.setThumbImage(UIImage(named: "thumb.png"), for: .normal)
        sld_Volumee.setThumbImage(UIImage(named: "thumbHightLight.png"), for: .highlighted)
    }
//play
    @IBAction func action_Play(_ sender: Any) {
// neu dang play: chuyen doi icon sang pause
        if playing {
            time = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            audio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "nnca", ofType: "mp3")!))
            audio.delegate = self
            audio.prepareToPlay()
            audio.play()
            checkRepeat()
            playing = false
           
            btn_Play.setImage(UIImage(named: "pause.png"), for: .normal)
//neu dang pause:chuyen doi icon sang play,ngung ham thoi gian,mp3 dung.
        }else {
            audio.pause()
            btn_Play.setImage(UIImage(named: "play.png"), for: .normal)
            time.invalidate()
            playing = true
        }
    }
//chinh volume
    @IBAction func btn_Volume(_ sender: UISlider) {
        audio.volume = sender.value
        
    }
//khi repeat false thi icon chuyen doi
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    
    btn_Play.setImage(UIImage(named: "play.png"), for: .normal)
    }
//xet thoi gian tuong duong voi gia tri cua slider duration
    @IBAction func sld_Timer(_ sender: UISlider) {
        audio.currentTime = TimeInterval(Float(sender.value) * Float(audio.duration))

    }

    @IBAction func action_Repeat(_ sender: UISwitch) {
        checkRepeat()
    }
// repeat mp3
//numberloop la ham repeat
    func checkRepeat(){
        if check.isOn == true {
            
            audio.numberOfLoops = -1
        }else{
            audio.numberOfLoops = 0
        }
    }
}

