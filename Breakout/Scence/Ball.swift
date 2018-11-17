//
//  Ball.swift
//  Breakout
//
//  Created by Satoshi Komatsu on 2018/10/20.
//  Copyright © 2018 木村　僚介. All rights reserved.
//
import Foundation
import GameplayKit
final class Ball: SKSpriteNode {
    
    func setUp() {
        self.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
    }
    
    func positionSet( x: CGFloat, y: CGFloat) {
        self.position.x = x
        self.position.y = y
    }
    
    func initPosition() {
        self.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
        self.physicsBody?.velocity = CGVector(dx: 312.5, dy: 312.5)
    }
}
