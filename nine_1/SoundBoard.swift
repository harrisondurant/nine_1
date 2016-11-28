//
//  SoundBoard.swift
//  testproject
//
//  Created by Harrison Durant on 11/21/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import AudioKit

class SoundBoard: AKMixer {
    
    var selectedIdx: Int = -1
    var pads: [Sound] = []
    
    init(_ fileNames: [String]) {
        super.init()
        
        for path in fileNames {
            do {
                let sound = try Sound(path)
                pads.append(sound)
                self.connect(sound)
            } catch {
                print("Sound file \(path) not found")
            }
        }
    }
    
    func play(_ soundID: Int) {
        pads[soundID].play()
        selectedIdx = soundID
    }
    
    func stop(_ soundID: Int) {
        pads[soundID].stop()
    }
}
