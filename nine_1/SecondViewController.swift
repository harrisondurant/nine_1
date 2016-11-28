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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        soundBoard = AudioKit.output as! SoundBoard
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let idx = soundBoard.selectedIdx
        if(idx >= 0) {
            aLabel.text = "Current Sound: \(idx)"
        } else {
            aLabel.text = "no sound selected"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

