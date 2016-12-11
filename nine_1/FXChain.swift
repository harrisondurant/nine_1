//
//  FXChain.swift
//  nine_1
//
//  Created by Harrison Durant on 12/7/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import UIKit
import AudioKit

class FXChain: AKMixer {
    
    var input: SoundBoard!
    
    var reverb: AKReverb!
    var delay: AKDelay!
    var HPF: AKHighPassFilter!
    var LPF: AKLowPassFilter!
    
    
    init(_ mixer: SoundBoard, _ updates: [Double]) {
        super.init()
        input = mixer
        
        setupFX()
        executeUpdates(updates: updates)
    }
    
    func executeUpdates(updates: [Double]) {
        let functions = [setVerb, setDelayTime,
                         setDelayFeedback, setLPFCutoff,
                         setHPFCutoff]
        
        if(updates.count != 0) {
            var i = 0
            for updateFX in functions {
                updateFX(updates[i])
                i+=1
            }
        }
    }
    
    func setupFX() {
        print("\n\n\nHERE")
        reverb = AKReverb(input)
        setVerb(0.0)
        delay = AKDelay(reverb)
        setDelayTime(0.01)
        setDelayFeedback(0.0)
        HPF = AKHighPassFilter(delay)
        setHPFCutoff(0.0)
        LPF = AKLowPassFilter(HPF)
        setLPFCutoff(8000.0)
        self.connect(LPF)
    }
    
    func setVerb(_ verb: Double) {
        print("At setverb - newvalue = \(verb)")
        reverb.dryWetMix = verb
    }
    
    func setDelayTime(_ time: Double) {
        print("At setdTime - newvalue = \(time)")
        delay.time = time
    }
    
    func setDelayFeedback(_ feedback: Double) {
        print("At setdfeedback - newvalue = \(feedback)")
        delay.dryWetMix = feedback
        delay.feedback = feedback
    }
    
    func setHPFCutoff(_ cutoff: Double) {
        print("At HPFCutoff - newvalue = \(cutoff)")
        HPF.cutoffFrequency = cutoff
    }
    
    func setLPFCutoff(_ cutoff: Double) {
        print("At LPFCutoff - newvalue = \(cutoff)\n\n\n")
        LPF.cutoffFrequency = cutoff
    }
}
