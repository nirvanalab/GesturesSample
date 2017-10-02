//
//  ShakeGestureViewController.swift
//  GestureTutorial
//
//  Created by Nirvana on 9/22/17.
//  Copyright © 2017 Nirvana. All rights reserved.
//

import UIKit


/// Reference for Responder events: https://developer.apple.com/documentation/uikit/uiresponder
class ShakeGestureViewController: UIViewController {

    @IBOutlet weak var shakeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Tells the receiver that a motion event has ended.
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.shakeLabel.text = "Shook!"
        }        
    }
    
    @IBAction func onReset(_ sender: UIButton) {
        self.shakeLabel.text = "Shake Me!"
    }
    
}
