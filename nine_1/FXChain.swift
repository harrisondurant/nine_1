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
    
    // SoundBoard will input signal to FXChain
    var input: SoundBoard!
    
    // FX nodes
    var bitcrush: AKBitCrusher!
    var reverb: AKReverb!
    var HPF: AKHighPassFilter!
    var LPF: AKLowPassFilter!
    
    
    init(_ mixer: SoundBoard, _ updates: [Double]) {
        super.init()
        input = mixer
        
        // set up each FX node
        setupFX()
        executeUpdates(updates: updates)
    }
    
    // Update each FX node given supplied updates
    func executeUpdates(updates: [Double]) {
        let functions = [toggleBitCrush,
                         setVerb, setBitDepth,
                         setSampleRate, setLPFCutoff,
                         setHPFCutoff]
        
        if(updates.count != 0) {
            var i = 0
            for updateFX in functions {
                updateFX(updates[i])
                i+=1
            }
        }
    }
    
    /*
    Chain each FX node to the input in sequence.
    Set initial values.
    */
    func setupFX() {
        bitcrush = AKBitCrusher(input)
        toggleBitCrush(1.0)
        setBitDepth(6.0)
        setSampleRate(10000.0)
        reverb = AKReverb(bitcrush)
        setVerb(0.0)
        HPF = AKHighPassFilter(reverb)
        setHPFCutoff(0.0)
        LPF = AKLowPassFilter(HPF)
        setLPFCutoff(8000.0)
        self.connect(LPF)
    }
    
    func toggleBitCrush(_ setting: Double) {
        if(setting == 0.0) {
            bitcrush.start()
        } else {
            bitcrush.stop()
        }
    }
    
    func setVerb(_ verb: Double) {
        reverb.dryWetMix = verb
    }
    
    func setBitDepth(_ depth: Double) {
        bitcrush.bitDepth = depth
    }
    
    func setSampleRate(_ sampRate: Double) {
        bitcrush.sampleRate = sampRate
    }
    
    func setHPFCutoff(_ cutoff: Double) {
        HPF.cutoffFrequency = cutoff
    }
    
    func setLPFCutoff(_ cutoff: Double) {
        LPF.cutoffFrequency = cutoff
    }
}
