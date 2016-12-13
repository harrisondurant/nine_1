//
//  SettingsViewController.swift
//  nine_1
//
//  Created by Harrison Durant on 12/7/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import UIKit
import AudioKit

class SettingsViewController: UIViewController {
    
    // bitcrush on/off switch
    @IBOutlet weak var bitcrushOnOffSwitch: UISegmentedControl!
    // slider outlet variables for each effect
    @IBOutlet weak var reverbSlider: AKPropertySlider!
    @IBOutlet weak var bitDepthSlider: AKPropertySlider!
    @IBOutlet weak var sampleRateSlider: AKPropertySlider!
    @IBOutlet weak var LPFSlider: AKPropertySlider!
    @IBOutlet weak var HPFSlider: AKPropertySlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         set text color to white. taken from:
         http://stackoverflow.com/questions/21156349/uisegmentedcontrol-only-changes-text-color-when-revisiting-viewcontroller
        */
        let titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        bitcrushOnOffSwitch.setTitleTextAttributes(titleTextAttributes, for: .normal)
        bitcrushOnOffSwitch.setTitleTextAttributes(titleTextAttributes, for: .selected)
    }

    // upon the view disappearing, update SoundBoard with new slider values
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let onOff = Double(bitcrushOnOffSwitch.selectedSegmentIndex)
        let verb = reverbSlider.value
        let bitDepth = bitDepthSlider.value
        let sampRate = sampleRateSlider.value
        let LPFcutoff = LPFSlider.value
        let HPFcutoff = HPFSlider.value
        let updates = [onOff,verb,bitDepth,sampRate,LPFcutoff,HPFcutoff]
        AudioKit.output = SoundBoard.updateFXChain(updates)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
