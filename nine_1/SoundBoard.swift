//
//  SoundBoard.swift
//  testproject
//
//  Created by Harrison Durant on 11/21/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import AudioKit

class SoundBoard: AKMixer {
    
    /* 
    static instance of SoundBoard.
    initialized with preset sounds and 
    bottom left pad as the default selected pad
    */
    private static var instance =
                SoundBoard(fileIDs: [13,38,5,28,26,6,19,44,32], startIndex: 6)
    
    // list of sound file names. contents of Resources directory
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
    
    /*
    dictionary mapping playback rate and volume 
    settings to sounds
    */
    var FXMap: [Int: (Double,Double)]!
    
    /* 
    list containing FXChain update parameters.
    passed to FXChain update method when updates have been made 
    */
    var FXChainParam: [Double]!
    
    // FXChain output that sends input signal to various effects
    var output: FXChain!
    
    // currently selected sound
    var selectedSound: Sound!
    
    // drumpad index [0..8] of selected sound
    var selectedIdx: Int!
    
    // list of sounds in SoundBoard
    var pads: [Sound] = []
    
    /*
    Initialize the SoundBoard.
    Parameters:
        fileIDs: soundList indices of new soundfiles
        startIndex: drumpad index [0...8] of starting selected pad
        fx: FXMap containing playback rate and volume settings 
            for each drumpad sound
        updates: FXChain parameters to update
    */
    init(fileIDs: [Int], startIndex: Int,
         _ fx: [Int: (Double,Double)] = [:],
         _ updates: [Double] = []) {
        super.init()
        
        // set FXMap and FXChainParam
        self.FXMap = fx
        self.FXChainParam = updates
//        
//        if(fx.count > 0) {
//            self.FXMap = fx
//        }
//        
//        if(updates.count > 0) {
//            self.FXChainParam = updates
//        }
//
        
        // keep track of index
        var count = 0
        
        /* for each soundList index in fileIDS, 
        create Sound object, and connect it to the SoundBoard.
        if there are any playback rate or volume setting adjustments
        in FXMap, set them accordingly
        */
        for idx in fileIDs {
            // get sound filename
            let path = SoundBoard.soundList[idx]
            do {
                // create Sound object
                let sound = try Sound(path,idx)
                
                // if there are any adustments to be made...
                if(FXMap[count] != nil) {
                    let rate = FXMap[count]!.0
                    let volume = FXMap[count]!.1
                    sound.setPlaybackRate(rate)
                    sound.setVolume(volume)
                }
                
                // connect audio engine to Sound
                self.pads.append(sound)
                self.connect(sound)
                
            } catch {
                print("Sound file \(path) not found")
            }
            count += 1
        }
        
        // connect to output FXChain
        self.output = FXChain(self,self.FXChainParam)
        
        // set selected index
        self.selectedIdx = startIndex
        
        // set selected sound
        self.selectedSound = pads[selectedIdx]
    }
    
    /* 
    Get static instance of SoundBoard.
    return output to connect to audio engine 
    */
    static func getInstance() -> FXChain {
        return instance.output
    }

    /*
    Called from SoundList View when a drumpad is assigned a new Sound.
    Removes previously selected sound and replaces it.
    Returns new instance with updated drumpads
    */
    static func updateSounds(soundListIdx: Int) -> FXChain {
        disconnect()
        /*
        if there are any playback or volume settings corresponding
        to the selected sound, remove them.
        */
        if(instance.FXMap[instance.selectedIdx] != nil) {
            instance.FXMap.removeValue(forKey: instance.selectedIdx)
        }
        
        // get soundList indices of drumpads, replace old with new
        var new_IDs = instance.getPadIndices()
        new_IDs[instance.selectedIdx] = soundListIdx
        
        // create new instance
        
        instance = SoundBoard(fileIDs: new_IDs,
                              startIndex: instance.selectedIdx,
                              instance.FXMap,
                              instance.FXChainParam)
        return instance.output
    }
    
    /*
    Called from Sound Editor View when playback or volume updates
    have been made. Stores updates in FXMap and creates new instance.
    */
    static func updateFX(rate: Double, volume: Double) -> FXChain {
        disconnect()
        instance.FXMap[instance.selectedIdx] = (rate,volume)
        instance = SoundBoard(fileIDs:
            instance.getPadIndices(), startIndex: instance.selectedIdx,
                                instance.FXMap,
                                instance.FXChainParam)
        return instance.output
    }
    
    /* 
    Called from Settings View when FXChain parameter updates
    have been made. Stores updates in FXChainParam and creates new instance.
    */
    static func updateFXChain(_ updates: [Double]) -> FXChain {
        disconnect()
        instance = SoundBoard(fileIDs: instance.getPadIndices(),
                              startIndex: instance.selectedIdx,
                              instance.FXMap, updates)
        return instance.output
    }
    
    /* 
    Plays the selected sound and sets the selectedSound 
    and selectedIdx variables.
    */
    static func play(_ soundID: Int) {
        let sound = instance.pads[soundID]
        sound.play()
        instance.selectedSound = sound
        instance.selectedIdx = soundID
    }
    
    /*
    Called before creating a new instance. 
    Disconnect the old instance from the audio engine
    */
    static func disconnect() {
        AudioKit.engine.disconnectNodeInput(instance.output.avAudioNode)
    }
    
    // Returns the soundList indices of the current drumpad sounds
    func getPadIndices() -> [Int] {
        var indices: [Int] = []
        for sound in pads {
            indices.append(sound.getSoundListIndex())
        }
        return indices
    }
    
    // get playback rate of selected sound
    static func getPlaybackRate() -> Double {
        return instance.selectedSound.getPlaybackRate()
    }
    
    // get volume of selected sound
    static func getVolume() -> Double {
        return instance.selectedSound.getVolume()
    }
    
    // get name of selected sound
    static func getSoundName() -> String {
        return instance.selectedSound.getName()
    }
    
    // get selected sound waveform image
    static func getCurrentWaveForm() -> UIImage {
        return instance.selectedSound.getWaveform()
    }
    
    // get soundList index of selected sound
    static func getSelectedIndex() -> Int {
        return instance.selectedSound.getSoundListIndex()
    }
    
    // get soundList
    static func getSoundList() -> [String] {
        return soundList
    }
}
