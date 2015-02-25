//
//  ViewController.swift
//  ObjectsFallEverywhere
//
//  Created by Nearpoint on 6/15/14.
//  Copyright (c) 2014 Nearpoint. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
                            
    @IBOutlet var gameView : UIView?
    let DROP_SIZE = CGSize(width: 40, height: 40)
    
    var angle: CDouble?
    lazy var push: UIPushBehavior = UIPushBehavior()
    
    lazy var dropitBehavior: DropitBehavior =
    {
        var _dropitBehavior = DropitBehavior()
        self.animator.addBehavior(_dropitBehavior)
        return _dropitBehavior
    }()
    
    lazy var animator: UIDynamicAnimator = UIDynamicAnimator(referenceView: self.gameView!)
    
    lazy var motionManager: CMMotionManager = CMMotionManager()

    @IBAction func tap(sender : AnyObject) {
        self.drop()
    }
    
    func startMyMotionDetect()
    {
        self.motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue(), withHandler: {
            (data: CMAccelerometerData!, error: NSError!) in
            dispatch_async(dispatch_get_main_queue()) {
                var xx = data.acceleration.x
                var yy = -data.acceleration.y
                self.angle = atan2(yy, xx)
                self.dropitBehavior.gravityAngle = CGFloat(self.angle!)
            }
        })
    }
    
    func drop() {
        var frame = CGRect()
        frame.origin = CGPointZero
        frame.size = DROP_SIZE
        
        var x: Int = Int(arc4random_uniform(UInt32(0.5))) / Int(DROP_SIZE.width)
        frame.origin.x = CGFloat(x) * CGFloat(DROP_SIZE.width)
        
        var dropView: TestView = TestView(frame: frame)
        dropView.backgroundColor = randomColor()
        dropView.layer.cornerRadius = 20
        dropView.layer.masksToBounds = true
        dropView.userInteractionEnabled = true
        var panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: dropView, action: "panHandler:")
        dropView.addGestureRecognizer(panGesture)
        dropView.delegate = self
        self.gameView?.addSubview(dropView)
        self.push.addItem(dropView)
        self.dropitBehavior.addItem(dropView)
        self.dropitBehavior.addItem(dropView)
    }
    
    func randomColor() -> UIColor {
        switch (arc4random() % 5) {
            case 0: return UIColor.greenColor()
                
            case 1: return UIColor.blueColor()
                
            case 2: return UIColor.orangeColor()
                
            case 3: return UIColor.redColor()
                
            case 4: return UIColor.purpleColor()
            
            default: return UIColor.blueColor()
        }
    }
    
//    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent)
//    {
//        if (motion == UIEventSubtype.MotionShake)
//        {
//            //println("Shake Started")
//            if let deviceAngle = self.angle {
//                self.push.angle = -CGFloat(deviceAngle)
//            } else {
//                self.push.angle = 0
//            }
//            
//            //println(self.push.angle)
//            self.push.magnitude = 2.0
//            self.animator.addBehavior(self.push)
//        }
//    }
//    
//    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent)
//    {
//        if (motion == UIEventSubtype.MotionShake)
//        {
//          //println("Shake Ended")
//          self.animator.removeBehavior(self.push)
//        }
//    }

    override func canBecomeFirstResponder() -> Bool
    {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.motionManager.startDeviceMotionUpdates()
        self.motionManager.accelerometerUpdateInterval  = 1.0/10.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.startMyMotionDetect()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.motionManager.stopAccelerometerUpdates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

