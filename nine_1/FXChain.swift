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
    var delay: AKVariableDelay!
    var HPF: AKHighPassFilter!
    var LPF: AKLowPassFilter!
    
    
    init(_ mixer: SoundBoard, _ updates: [Double]) {
        super.init()
        input = mixer
        reverb = AKReverb(input)
        delay = AKVariableDelay(reverb)
        HPF = AKHighPassFilter(delay)
        LPF = AKLowPassFilter(HPF)
        
        executeUpdates(updates: updates)
        self.connect(LPF)
    }
    
    func executeUpdates(updates: [Double]) {
        let functions = [setVerb, setDelayTime,
                         setDelayFeedback, setHPFCutoff,
                         setLPFCutoff]
        
        if(updates.count != 0) {
            var i = 0
            for updateFX in functions {
                updateFX(updates[i])
                i+=1
            }
        }
        
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
        delay.feedback = feedback
    }
    
    func setHPFCutoff(_ cutoff: Double) {
        HPF.cutoffFrequency = cutoff
    }
    
    func setLPFCutoff(_ cutoff: Double) {
        LPF.cutoffFrequency = cutoff
    }
}
