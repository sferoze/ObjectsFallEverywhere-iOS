//
//  testView.swift
//  ObjectsFallEverywhere
//
//  Created by Nearpoint on 6/15/14.
//  Copyright (c) 2014 Nearpoint. All rights reserved.
//

import Foundation
import UIKit

class TestView: UIView
{
    var attachment: UIAttachmentBehavior?
    var delegate: ViewController?
    /*
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!)
    {
        var point: CGPoint = touches.anyObject().locationInView(self.superview)
        self.center = point
    }
    */
    func panHandler(gesture: UIPanGestureRecognizer)
    {
        
        var gesturePoint: CGPoint = gesture.locationInView(self.superview)
        if (gesture.state == UIGestureRecognizerState.Began) {
            println("panning BEGAN")
            //self.superview.bringSubviewToFront(self)
            self.attachViewToPoint(gesturePoint)
        } else if (gesture.state == UIGestureRecognizerState.Changed) {
            println("panning CHANGED")
            //CGPoint startingPoint = [gesture locationInView:gesture.view];
            //var point: CGPoint = gesture.locationInView(self.superview)
            //self.center = point
            self.attachment!.anchorPoint = gesturePoint
            
        } else if (gesture.state == UIGestureRecognizerState.Ended) {
            println("panning ENDED")
            //CGPoint endPoint = [gesture locationInView:gesture.view];
            var endPoint: CGPoint = gesture.locationInView(gesture.view)
            self.delegate!.animator.removeBehavior(self.attachment)
        }
    }
    
    func attachViewToPoint(anchorPoint: CGPoint)
    {
        println("attachmenttoView")
        //println("called")
        self.attachment = UIAttachmentBehavior(item: self, attachedToAnchor: anchorPoint)
        self.delegate!.animator.addBehavior(self.attachment)
        
    }

}
