//
//  FirstViewController.swift
//  nine_1
//
//  Created by Harrison Durant on 11/28/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import UIKit
import AudioKit

class FirstViewController: UIViewController {
    
    // drumpad buttons in main view
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    
    let numPads = 9
    
    var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initalize button list
        buttons = [button0,button1,button2,
                   button3,button4,button5,
                   button6,button7,button8]
        
        // set the default selected drumpad to bottom left
        updateImages(selectedIdx: 6)
        
        // set audio output to static instance of SoundBoard class
        AudioKit.output = SoundBoard.getInstance()
    }
    
    // when main view appears, start audio engine
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AudioKit.start()
    }
    
    /* 
    when main view disappears, no audio will be playing.
    temporarily stop audio engine 
    */
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        AudioKit.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /* 
    button press event handler:
    using storyboard assigned button identifiers,
    play corresponding sound, and update the view 
    */
    @IBAction func padDown(_ sender: UIButton) {
        let id = Int(sender.restorationIdentifier!)!
        SoundBoard.play(id)
        updateImages(selectedIdx: id)
    }
    
    /* 
    set the image for the currently selected drum pad to
    'selectedPad', set all others to 'defaultPad'. called when
    a button is pressed 
    */
    func updateImages(selectedIdx: Int) {
        for i in 0..<numPads {
            if(i == selectedIdx) {
                buttons[i].setImage(#imageLiteral(resourceName: "selectedPad"),for: .normal)
            } else {
                buttons[i].setImage(#imageLiteral(resourceName: "defaultPad"),for: .normal)
            }
        }
    }
}

