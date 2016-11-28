//
//  Sound.swift
//  testproject
//
//  Created by Harrison Durant on 11/21/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import AudioKit

class Sound: AKAudioPlayer {
    
    init(file audioFile: AKAudioFile) throws {
        try super.init(file: audioFile)
    }
    
    convenience init(_ fileName: String) throws{
        var sound: AKAudioFile!
        do {
            try sound = AKAudioFile(readFileName: fileName)
        } catch {
            print("Exception occurred")
        }
        try self.init(file: sound)
    }
}
