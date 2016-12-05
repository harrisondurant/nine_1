//
//  SoundBoard.swift
//  testproject
//
//  Created by Harrison Durant on 11/21/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import AudioKit

class SoundBoard: AKMixer {
    
    private static var instance =
                SoundBoard(fileIDs: [13,38,5,28,26,6,19,44,32], startIndex: 6)
    
    private static var soundList = ["(Kick) FSMH1.mp3","[Snr] BEAUTIFUL MORNIN.mp3",
                     "[VOX] BBB4U Quickie.mp3","100.mp3","Air_funk.mp3",
                     "airhorn.mp3","another-one.mp3","BALTIMOR.mp3",
                     "Caddy_ki.mp3","chop1.mp3","chop2.mp3","chop4.mp3",
                     "clap.mp3","crash.mp3","crash1.mp3","Doggiek.mp3",
                     "explore_clap.mp3","explore_fx.mp3","explore_kick_1.mp3",
                     "explore_kick_2.mp3","explore_kick_3.mp3","explore_perc.mp3",
                     "explore_snap1.mp3","explore_snap2.mp3","explore_snare1.mp3",
                     "explore_snare2.mp3","explore_snare3.mp3","fatkick.mp3",
                     "FX9.mp3","Glitch_Hop_Kick05.mp3","haan.mp3","hey.mp3",
                     "hh1.mp3","hh2.mp3","hih1.mp3","hih2.mp3","ironside.mp3",
                     "milli.mp3","montana.mp3","Ohiokic.mp3","Perfect.mp3",
                     "s3.mp3","shout.mp3","Sound192.mp3","tightsnare.mp3","zap1.mp3"]
    
    var FXMap: [Int: (Double,Double)] = [:]
    
    var selectedSound: Sound!
    var selectedIdx: Int!
    
    var pads: [Sound] = []
    
    init(fileIDs: [Int], startIndex: Int, _ fx: [Int: (Double,Double)] = [:]) {
        super.init()
        
        var count = 0
        
        if(fx.count > 0) {
            self.FXMap = fx
        }
        
        for idx in fileIDs {
            let path = SoundBoard.soundList[idx]
            do {
                let sound = try Sound(path,idx)
                if(FXMap[count] != nil) {
                    let rate = FXMap[count]!.0
                    let pan = FXMap[count]!.1
                    sound.setRate(rate)
                    sound.setPan(pan)
                }
                pads.append(sound)
                
                self.connect(sound)
            } catch {
                print("Sound file \(path) not found")
            }
            count += 1
        }
        
        selectedIdx = startIndex
        selectedSound = pads[selectedIdx]
    }
    
    static func getInstance() -> SoundBoard {
        return instance
    }
    
    static func updateSounds(soundIdx: Int) -> SoundBoard {
        if(instance.FXMap[instance.selectedIdx] != nil) {
            instance.FXMap.removeValue(forKey: instance.selectedIdx)
        }
        
        var new_IDs = instance.getPads()
        new_IDs[instance.selectedIdx] = soundIdx
        
        instance = SoundBoard(fileIDs: new_IDs,
                              startIndex: instance.selectedIdx, instance.FXMap)
        return instance
    }
    
    static func updateFX(rate: Double, pan: Double) -> SoundBoard {
        instance.FXMap[instance.selectedIdx] = (rate,pan)
        instance = SoundBoard(fileIDs:
            instance.getPads(), startIndex: instance.selectedIdx, instance.FXMap)
        return instance
    }
    
    static func play(_ soundID: Int) {
        let sound = instance.pads[soundID]
        if(sound.canTrigger) {
            sound.playSound()
        }
        instance.selectedSound = sound
        instance.selectedIdx = soundID
    }
    
    static func stop(_ soundID: Int) {
        instance.pads[soundID].stopSound()
    }
    
    func getPads() -> [Int] {
        var idxs: [Int] = []
        for sound in pads {
            idxs.append(sound.soundListIndex)
        }
        return idxs
    }
    
    static func getPlayback() -> Double {
        return instance.selectedSound.output.rate
    }
    
    static func getPan() -> Double {
        return instance.selectedSound.input.pan
    }
    
    static func getSoundName() -> String {
        return instance.selectedSound.name
    }
    
    static func getSelectedIndex() -> Int {
        return instance.selectedSound.soundListIndex
    }
    
    static func getSoundList() -> [String] {
        return soundList
    }
}
