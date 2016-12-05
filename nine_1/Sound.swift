//
//  Sound.swift
//  testproject
//
//  Created by Harrison Durant on 11/21/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import AudioKit

class Sound: AKMixer {
    
    var name: String = ""
    var soundListIndex: Int = -1
    var canTrigger: Bool = true
    var input: AKAudioPlayer!
    var output: AKVariSpeed!
    
    init(_ fileName: String, _ idx: Int) throws {
        super.init()
        do {
            let soundFile = try AKAudioFile(readFileName: fileName)
            self.input = try AKAudioPlayer(file: soundFile)
        } catch {
            print("Exception occurred")
        }
        self.name = fileName
        self.soundListIndex = idx
        self.output = AKVariSpeed(self.input)
        self.connect(self.output)
    }
    
    func playSound() {
        if(input.isPlaying) {
            input.stop()
        }
        canTrigger = false
        input.play()
    }
    
    func stopSound() {
        canTrigger = true
    }
    
    func replace(_ fileName: String, _ idx: Int) {
        do {
            let soundFile = try AKAudioFile(readFileName: fileName)
            input = try AKAudioPlayer(file: soundFile)
            output = AKVariSpeed(input)
            connect(self.output)
            soundListIndex = idx
        } catch {
            print("Exception occurred")
        }
    }
}

//class Sound: AKAudioPlayer {
//
//    var name: String = ""
//    var soundListIndex: Int = -1
//    var canTrigger: Bool = true
//
//    init(file audioFile: AKAudioFile) throws {
//        try super.init(file: audioFile)
//    }
//
//    convenience init(_ fileName: String, _ idx: Int) throws {
//        var sound: AKAudioFile!
//        do {
//            try sound = AKAudioFile(readFileName: fileName)
//        } catch {
//            print("Exception occurred")
//        }
//        try self.init(file: sound)
//        self.name = fileName
//        self.soundListIndex = idx
//    }
//
//    func playSound() {
//        if(self.isPlaying) {
//            self.stop()
//        }
//        self.canTrigger = false
//        self.play()
//    }
//
//    func stopSound() {
//        self.canTrigger = true
//    }
//}

