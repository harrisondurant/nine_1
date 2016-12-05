//
//  Sound.swift
//  testproject
//
//  Created by Harrison Durant on 11/21/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import AudioKit

class Sound: AKAudioPlayer {
    
    var name: String = ""
    var soundListIndex: Int = -1
    var canTrigger: Bool = true
    
    init(file audioFile: AKAudioFile) throws {
        try super.init(file: audioFile)
    }
    
    convenience init(_ fileName: String, _ idx: Int) throws {
        var sound: AKAudioFile!
        do {
            try sound = AKAudioFile(readFileName: fileName)
        } catch {
            print("Exception occurred")
        }
        try self.init(file: sound)
        self.name = fileName
        self.soundListIndex = idx
    }
    
    func playSound() {
        if(self.isPlaying) {
            self.stop()
        }
        self.canTrigger = false
        self.play()
    }
    
    func stopSound() {
        self.canTrigger = true
    }
}
