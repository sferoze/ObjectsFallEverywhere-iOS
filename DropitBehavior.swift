//
//  DropitBehavior.swift
//  ObjectsFallEverywhere
//
//  Created by Nearpoint on 6/15/14.
//  Copyright (c) 2014 Nearpoint. All rights reserved.
//

import Foundation
import UIKit


class DropitBehavior: UIDynamicBehavior
{
    lazy var gravity: UIGravityBehavior = UIGravityBehavior()
    
    var gravityAngle: CGFloat
    {
        set {
            self.gravity.angle = newValue
            
        }
        get {
            return self.gravity.angle
        }
    }

    lazy var collider: UICollisionBehavior =
    {
        var _collider = UICollisionBehavior()
        _collider.translatesReferenceBoundsIntoBoundary = true
        return _collider
    }()

    
    override init()
    {
        super.init()
        self.addChildBehavior(self.gravity)
        self.addChildBehavior(self.collider)
    }
    
    func addItem(item: UIDynamicItem) {
        self.gravity.addItem(item)
        self.collider.addItem(item)
    }
    
    func removeItem(item: UIDynamicItem) {
        self.gravity.removeItem(item)
        self.collider.removeItem(item)
    }
}