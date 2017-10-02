//
//  ScreenEdgeViewController.swift
//  GestureTutorial
//
//  Created by Nirvana on 9/21/17.
//  Copyright © 2017 Nirvana. All rights reserved.
//

import UIKit

class ScreenEdgeViewController: UIViewController {

    @IBOutlet weak var sideView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideView.frame.origin.x -= sideView.frame.size.width
    }
    
    // set the status bar true to detect top and bottom edge pan
    // reference: https://stackoverflow.com/questions/25571538/uiscreenedgepangesturerecognizer-top-and-bottom-edges
//    override var prefersStatusBarHidden: Bool {
//        return true;
//    }

    /// Similar to pan gesture recognizer but detects that
    /// start near an edge
    ///
    /// - Parameter sender: screen edge pan gesture recognizer
    @IBAction func handleScreenEdge(_ sender: UIScreenEdgePanGestureRecognizer) {
        
        //get the translation
        let translation = sender.translation(in: self.view)
        if sender.state == .changed {
            if self.sideView.frame.origin.x < 0  {
                //if state is changed and the x coordinate of the origin is till less than 0, then update the frame to the amount panned
                self.sideView.frame.origin.x += translation.x
            }
        }
        
        //if the state has ended and if the side view is not shown completely yet then hide it using animation
        if  sender.state == .ended && self.sideView.frame.origin.x < 0 {
            
            UIView.animate(withDuration: 1.0, delay: 0.2, usingSpringWithDamping:
                0.3, initialSpringVelocity: max(1.0,sender.velocity(in: sender.view!).x), options: [], animations: {
                    
                   self.sideView.frame.origin.x = -self.sideView.frame.size.width
                    
            }) { _ in
                
            }

            
        }
        //reset the translation to 0
        sender.setTranslation(CGPoint.zero, in: self.view)
    }

  
    @IBAction func handleSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        
        UIView.animate(withDuration: 0.5) { 
             self.sideView.frame.origin.x = -self.sideView.frame.size.width
        }
    }

}
