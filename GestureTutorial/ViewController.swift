//
//  ViewController.swift
//  GestureTutorial
//
//  Created by Nirvana on 9/18/17.
//  Copyright © 2017 Nirvana. All rights reserved.
//

import UIKit

//cancelTouchesInView - determines if the touches need to be sent to the view once the gesture is recognized
// Gesture recognizer only on a view but not on subviews: https://stackoverflow.com/questions/15814697/uitapgesturerecognizer-tap-on-self-view-but-ignore-subviews
class ViewController: UIViewController {
    
    let colors:[UIColor] = [.blue,.red,.yellow,.gray,.purple,.white,.orange,.green,.magenta,.brown];
    let animals:[String] = ["Crocodile","Elephant","fish","turtle"]
    var currentImgIndex = 0
    var previousIndex:Int = 0
    var toggle = false
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup tap gesture recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)));
        //set number of taps required
        tapGestureRecognizer.numberOfTapsRequired = 2

        //make sure the user interaction is enabled for imageview
        imageView.isUserInteractionEnabled = true
        //add the gesture recognizer to the corresponding view
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    /// Call back for tap gesture recognizer
    /// Discrete Gesture
    /// - Parameter sender: tap gesture recognizer
    func handleTap(_ sender:UITapGestureRecognizer) {
        updateImage()
    }
    
    /// Call back for pan gesture recognizer
    /// Continious Gesture
    /// Common properties to access location,translation and velocity
    /// location - is absolute position
    /// translation - how many points the view has moved since gesture began
    /// velocity - velocity of the pan gesture
    /// - Parameter sender: pan gesture recognizer
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
            case .began:
                NSLog("Pan Began")
                break
            case.changed:
                NSLog("Pan Changed")
                //The amount the user has moved their finger
                let translation = sender.translation(in: self.view)
                print(translation)
                //the absolute position in the view
                //let location = sender.location(in: self.view)
               
                if let view = sender.view {
                     //Move the center of the view to the same amount the finger has been dragged
                    view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
                    //Important to set the translation back to zero , otherwise it keeps compounding each time and the view will rapidly move offscreen
                    sender.setTranslation(CGPoint.zero, in: self.view)
                   // view.center = location
                }
                break
            case .ended:
                NSLog("Pan Ended")
            default:
                break;
            
        }
    }
    
    /// Call back for pinch gesture recognizer
    /// Continious Gesture
    ///  Common properties to access: scale
    /// - Parameter sender: pinch gesture recognizer
    @IBAction func handlePinch(_ sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .began:
            NSLog("Pinch Began")
            break
        case.changed:
            NSLog("Pinch Changed")
            if let view = sender.view {
                view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
                sender.scale = 1
            }
            break
        case .ended:

            NSLog("Pinch Ended")
        default:
            break;
            
        }
    }
    
    /// Call back for rotation gesture recognizer
    /// Continious Gesture
    /// Common properties to access: rotation
    /// - Parameter sender: rotation gesture recognizer
    @IBAction func handleRotation(_ sender: UIRotationGestureRecognizer) {
        switch sender.state {
        case .began:
            NSLog("Rotation Began")
            break
        case.changed:
            NSLog("Rotation Changed")
            if let view = sender.view {
                //view.transform = CGAffineTransform(rotationAngle: sender.rotation)
                view.transform = view.transform.rotated(by: sender.rotation)
                sender.rotation = 0
            }
            break
        case .ended:
            NSLog("Rotation Ended")
        default:
            break;
        }
    }
    
    /// Call back for swipe gesture recognizer
    /// Discrete Gesture
    /// - Parameter sender: swipe gesture recognizer
    @IBAction func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        
        var randomIndex = 0
        repeat {
              randomIndex = Int(arc4random_uniform(UInt32(colors.count)))
        }
        while (randomIndex == previousIndex )
        
        let randomColor = colors[randomIndex]
        self.view.backgroundColor = randomColor
    }
    
    /// Call back for long press gesture recognizer
    /// Continious Gesture
    /// 3d touch vs long press? http://mikepiontek.com/journal/3d-touch-vs-long-press.html
    /// - Parameter sender: long press gesture recognizer
    
    @IBAction func handleLongPress(_ sender: UILongPressGestureRecognizer) {

        if sender.state != .began {
            return;
        }
        updateImage()
    }
    
    //updates the image
    func updateImage() {
        currentImgIndex = (currentImgIndex == animals.count-1) ? 0 : currentImgIndex+1
        self.imageView.image = UIImage.init(named: animals[currentImgIndex])
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touch began")
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print ("touch moved")
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touch ended")
//    }
    
}

extension ViewController: UIGestureRecognizerDelegate {
    
    //Asks the delegate if two gesture recognizers should be allowed to recognize gestures simultaneously.
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        return true
//    }
}
