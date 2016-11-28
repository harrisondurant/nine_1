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
    
    //@IBOutlet weak var delayTime: AKPropertySlider!
    //@IBOutlet weak var delayFeedback: AKPropertySlider!
    
    let soundBoard = SoundBoard(["dirtykick.wav","clic.wav","bell.wav",
                                "clap.wav","snare.wav","tom.wav",
                                "congo.wav","shaker.wav","weird.wav"])
    
    // var delay: AKVariableDelay?
    //delay = AKVariableDelay(soundBoard)
    //delayTime.callback = adjustDelayTime
    //delayFeedback.callback = adjustDelayFeedback
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [button0,button1,button2,
                   button3,button4,button5,
                   button6,button7,button8]
        
        AudioKit.output = soundBoard
        AudioKit.start()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func padDown(_ sender: UIButton) {
        let id = Int(sender.restorationIdentifier!)!
        //print("Playing sound: \(id)")
        soundBoard.play(id)
        updateImages(selectedIdx: id)
    }
    
    @IBAction func padUp(_ sender: UIButton) {
        let id = Int(sender.restorationIdentifier!)!
        //print("Stopping sound: \(id)")
        soundBoard.stop(id)
    }
    
    func updateImages(selectedIdx: Int) {
        for i in 0..<numPads {
            if(i == selectedIdx) {
                buttons[i].setImage(#imageLiteral(resourceName: "selected"),for: .normal)
            } else {
                buttons[i].setImage(#imageLiteral(resourceName: "drumpad"),for: .normal)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("HEY")
    }

//    func adjustDelayTime(_ time: Double) {
//        delay?.time = Double(time)
//    }
//
//    func adjustDelayFeedback(_ feedback: Double) {
//        delay?.feedback = Double(feedback)
//    }

}

