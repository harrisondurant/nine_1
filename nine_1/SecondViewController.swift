//
//  SecondViewController.swift
//  nine_1
//
//  Created by Harrison Durant on 11/28/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import UIKit
import AudioKit

class SecondViewController: UIViewController {

    @IBOutlet weak var aLabel: UILabel!
    
    var soundBoard: SoundBoard!
    var soundName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soundBoard = SoundBoard.getInstance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let idx = soundBoard.selectedIdx!
        if(idx >= 0) {
            let currSound = soundBoard.selectedSound!
            aLabel.text = "Current Sound: \(currSound.name)"
            soundName = "Sound \(idx)"
        } else {
            aLabel.text = "no sound selected"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "changeSound") {
//            
//            let dest = segue.destination as! SoundListView
//            dest.editorView = self
//            
//        }
//    }
}

