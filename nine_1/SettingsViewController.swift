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

    @IBOutlet weak var reverbSlider: AKPropertySlider!
    @IBOutlet weak var delayTimeSlider: AKPropertySlider!
    @IBOutlet weak var delayFeedbackSlider: AKPropertySlider!
    @IBOutlet weak var LPFSlider: AKPropertySlider!
    @IBOutlet weak var HPFSlider: AKPropertySlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let verb = reverbSlider.value
        let dTime = delayTimeSlider.value
        let dFeedback = delayFeedbackSlider.value
        let LPFcutoff = LPFSlider.value
        let HPFcutoff = HPFSlider.value
        let updates = [verb,dTime,dFeedback,LPFcutoff,HPFcutoff]
        AudioKit.output = SoundBoard.updateFXChain(updates)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
