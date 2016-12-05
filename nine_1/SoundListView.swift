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

    @IBOutlet weak var scrollView: UIScrollView!
    var loaded = false
    
    var newSoundIdx: Int = -1
    
    var x: CGFloat = 0.0
    var offsetY: CGFloat = 0.0
    let padding: CGFloat = 5.0
    var w: CGFloat = 0.0
    var h: CGFloat = 30.0
    
    var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(!loaded) {
            setupSoundList()
            loaded = true
        }
        updateList(SoundBoard.getSelectedIndex())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        AudioKit.output = SoundBoard.updateSounds(soundIdx: newSoundIdx)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupSoundList() {
        
        let soundList = SoundBoard.getSoundList()
        let numSounds = soundList.count
        
        scrollView.contentInset = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 5.0, right: 0.0)
        scrollView.contentSize = CGSize(width: scrollView.frame.width,
                                        height: (h+padding)*CGFloat(numSounds))
        
        w = scrollView.frame.width - 2*padding
        x = scrollView.frame.minX + padding
        
        offsetY = 0.0
        for i in 0..<numSounds {
            let button = UIButton(type: .roundedRect)
            button.frame = CGRect(x: x, y: offsetY, width: w, height: h)
            
            button.layer.cornerRadius = 5
            button.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 1.0, alpha: 0.3)
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
    
    func updateList(_ idx: Int) {
        for button in buttons {
            let button_id = Int(button.restorationIdentifier!)!
            if(button_id == idx) {
                button.tintColor = UIColor.white
            } else {
                button.tintColor = UIColor.black
            }
        }
    }
    
    func selectSound(_ soundButton: UIButton) {
        newSoundIdx = Int(soundButton.restorationIdentifier!)!
        updateList(newSoundIdx)
    }

}
