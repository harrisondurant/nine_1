//
//  SecondViewController.swift
//  nine_1
//
//  Created by Harrison Durant on 11/28/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import UIKit
import AudioKit

class SecondViewController: UIViewController {
    
    // image view displaying waveform for selected sound
    @IBOutlet weak var waveformImage: UIImageView!
    
    // label displaying name of selected sound
    @IBOutlet weak var soundNameLabel: UILabel!
    
    // slider adjusting selected sound playback rate
    @IBOutlet weak var playbackSlider: AKPropertySlider!
    
    // slider adjusting selected sound volume
    @IBOutlet weak var volumeSlider: AKPropertySlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /* 
    when sound editor view appears, set the position of each slider
    to the corresponding settings of the selected sound, and set 
    the waveform image view + sound name label to the selected sound
    waveform and selected sound name.
    */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        playbackSlider.value = SoundBoard.getPlaybackRate()
        volumeSlider.value = SoundBoard.getVolume()
        
        print(SoundBoard.getSoundName())
        soundNameLabel.text = "Current Sound: \(SoundBoard.getSoundName())"
        waveformImage.image = SoundBoard.getCurrentWaveForm()
    }
    
    /*
    as soon as view disappears, update the soundboard and
    set the audio engine's output to the updated soundboard
    */
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        AudioKit.output = SoundBoard.updateFX(rate: playbackSlider.value,
                                            volume: volumeSlider.value)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

