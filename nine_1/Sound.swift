//
//  Sound.swift
//  testproject
//
//  Created by Harrison Durant on 11/21/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import AudioKit

class Sound: AKMixer {
    
    // sound name
    private var name: String = ""
    
    // sound waveform
    private var waveform: UIImage!
    
    // index of sound in SoundBoard.soundList
    private var soundListIndex: Int = -1
    
    /* audio player to play sound file.
    CustomAudioPlayer is nearly identical to AudioKit
    AKAudioPlayer with a few minor changes */
    private var input: CustomAudioPlayer!

    /* output of Sound will be a varispeed node,
    allowing for change of audio file playback rate */
    private var output: AKVariSpeed!
    
    init(_ fileName: String, _ idx: Int) throws {
        super.init()
        do {
            // create audio player with audio file.
            let soundFile = try AKAudioFile(readFileName: fileName)
            self.input = try CustomAudioPlayer(file: soundFile)
        } catch {
            print("Exception occurred")
        }
        
        // trim '.mp3' from fileName
        let endIdx = fileName.index(fileName.endIndex, offsetBy: -5)
        self.name = fileName[fileName.startIndex...endIdx]
        
        // get and set waveform image
        self.waveform = UIImage(named: self.name)
        self.soundListIndex = idx
        
        // connect input audio player to AKVariSpeed output
        self.output = AKVariSpeed(self.input)
        self.connect(self.output)
    }
    
    // play soun
    func play() {
        input.play()
    }
    
    // set sound playback rate
    func setPlaybackRate(_ rate: Double) {
        output.rate = rate
    }
    
    // return sound playback rate
    func getPlaybackRate() -> Double {
        return output.rate
    }
    
    // set sound volume
    func setVolume(_ volume: Double) {
        input.volume = volume
    }
    
    // get sound volume
    func getVolume() -> Double {
        return input.volume
    }
    
    // get sound name
    func getName() -> String {
        return name
    }
    
    // get sound waveform image
    func getWaveform() -> UIImage {
        return waveform
    }
    
    // get sound soundList index
    func getSoundListIndex() -> Int {
        return soundListIndex
    }
    
}

