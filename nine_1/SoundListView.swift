//
//  SoundListView.swift
//  nine_1
//
//  Created by Harrison Durant on 11/30/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import UIKit
import AudioKit

class SoundListView: UIViewController {
    
    // scroll view outlet variable
    @IBOutlet weak var scrollView: UIScrollView!
    
    // whether or not scrollview has been initialized
    var loaded = false
    
    // index of new sound
    var newSoundIdx: Int!
    
    // list storing new sound buttons
    var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // set up scroll view if it has not already been done
        if(!loaded) {
            setupSoundList()
            loaded = true
        }
        
        // get selected sound index and update scroll view accordingly
        newSoundIdx = SoundBoard.getSelectedIndex()
        updateList(newSoundIdx)
    }
    
    // Upon disappearing, update SoundBoard, add new sound
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        AudioKit.output = SoundBoard.updateSounds(soundListIdx: newSoundIdx)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupSoundList() {
        
        let soundList = SoundBoard.getSoundList()
        let numSounds = soundList.count
        
        // for content positioning
        var offsetY: CGFloat = 0.0
        let padding: CGFloat = 2.5
        let h: CGFloat = 36.0
        
        scrollView.contentInset = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 5.0, right: 0.0)
        scrollView.contentSize = CGSize(width: scrollView.frame.width,
                                        height: (h+padding)*CGFloat(numSounds))
        
        let w = scrollView.frame.width - 2*padding
        let x = scrollView.frame.minX + padding
        
        // create sound selector buttons and add them to scroll view
        for i in 0..<numSounds {
            let button = UIButton(type: .roundedRect)
            button.frame = CGRect(x: x, y: offsetY, width: w, height: h)
            
            button.layer.cornerRadius = 5
            button.setBackgroundImage(#imageLiteral(resourceName: "defaultPad"), for: .normal)
            button.tintColor =  UIColor.black
            
            button.titleLabel!.textAlignment = .left
            button.setTitle(soundList[i], for: .normal)
            
            button.addTarget(self, action: #selector(SoundListView.selectSound(_:)), for: .touchUpInside)
            button.restorationIdentifier = "\(i)"
            buttons.append(button)
            scrollView.addSubview(button)
            
            offsetY += h + padding
        }
    }
    
    /*
    Change color of selected sound button and reset color
    of previously selected sound button
    */
    func updateList(_ idx: Int) {
        for button in buttons {
            let button_id = Int(button.restorationIdentifier!)!
            if(button_id == idx) {
                let lightred = UIColor(red: 1.0, green: 0.4, blue: 0.3, alpha: 1)
                button.tintColor = lightred
            } else {
                button.tintColor = UIColor.black
            }
        }
    }
    
    /*
    Called whenever a button is pressed.
    Update the sound list and new sound index
    */
    func selectSound(_ soundButton: UIButton) {
        newSoundIdx = Int(soundButton.restorationIdentifier!)!
        updateList(newSoundIdx)
    }

}
