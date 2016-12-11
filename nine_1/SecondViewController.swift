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

    @IBOutlet weak var waveformImage: UIImageView!
    @IBOutlet weak var soundNameLabel: UILabel!
    
    
    @IBOutlet weak var playbackSlider: AKPropertySlider!
    @IBOutlet weak var volumeSlider: AKPropertySlider!
    
    var soundBoard: SoundBoard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        playbackSlider.value = SoundBoard.getPlayback()
        volumeSlider.value = SoundBoard.getVolume()
        
        soundNameLabel.text = "Current Sound: \(SoundBoard.getSoundName())"
        waveformImage.image = SoundBoard.getCurrentWaveForm()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        AudioKit.output = SoundBoard.updateFX(rate: playbackSlider.value,
                                            volume: volumeSlider.value)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

