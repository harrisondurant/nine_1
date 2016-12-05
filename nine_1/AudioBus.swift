//
//  AudioBus.swift
//  nine_1
//
//  Created by Harrison Durant on 12/4/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import AudioKit

class AudioBus: AKMixer {
    
    var input: Sound!
    var pitchShifter: AKPitchShifter!
    
    init(_ sound: Sound) {
        super.init()
        input = sound
        pitchShifter = AKPitchShifter(input)
        pitchShifter.shift = -6.0
        self.connect(pitchShifter)
    }
    
    func startPlaying() {
        if(input.canTrigger) {
            input.playSound()
        }
    }
    
    func stopPlaying() {
        input.stopSound()
    }
}
