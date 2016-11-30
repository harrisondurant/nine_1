//
//  SoundListView.swift
//  nine_1
//
//  Created by Harrison Durant on 11/30/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import UIKit

class SoundListView: UIViewController {

    @IBOutlet weak var pane: UIView!
    @IBOutlet weak var pane2: UIView!
    
    var selectedSound = ""
    var numSounds = 36
    
    var x: CGFloat = 0.0
    var offsetY: CGFloat = 0.0
    var w: CGFloat = 0.0
    var h: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("at sound list view, selected sound = \(selectedSound)")
        setupSoundList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupSoundList() {
        w = pane.frame.width
        x = pane.frame.minX
        h = pane.frame.height / CGFloat(numSounds/2)
        
        offsetY = 0
        for i in 1...numSounds/2 {
            let button = UIButton(frame: CGRect(x: 0.0, y: offsetY, width: w, height: h))
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(.black, for: .normal)
            button.setTitle("Sound \(i)", for: .normal)
            pane.addSubview(button)
            offsetY += h
        }
        
        offsetY = 0
        for j in numSounds/2+1...numSounds {
            let button = UIButton(frame: CGRect(x: 0.0, y: offsetY, width: w, height: h))
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(.black, for: .normal)
            button.setTitle("Sound \(j)", for: .normal)
            pane2.addSubview(button)
            offsetY += h

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
/*
 func setupSoundList() {
 w = pane.frame.width
 x = pane.frame.minX
 h = pane.frame.height / CGFloat(numSounds/2)
 
 offsetY = 0
 for i in 1...numSounds/2 {
 let button = UIButton(type: .roundedRect)
 button.frame =
 let label = UILabel(frame: CGRect(x: 0.0, y: offsetY, width: w, height: h))
 label.textAlignment = .center
 label.text = "Sound \(i)"
 pane.addSubview(label)
 offsetY += h
 }
 
 offsetY = 0
 for j in numSounds/2+1...numSounds {
 let label = UILabel(frame: CGRect(x: 0.0, y: offsetY, width: w, height: h))
 label.textAlignment = .center
 label.text = "Sound \(j)"
 pane2.addSubview(label)
 offsetY += h
 }
*/

}
