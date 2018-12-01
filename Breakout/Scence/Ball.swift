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
    
    var time : Int = 0
    
    func setUp() {
        self.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Ball.timerUpdate), userInfo: nil, repeats: true)
    }
    
    func positionSet( x: CGFloat, y: CGFloat) {
        self.position.x = x
        self.position.y = y
    }
    
    func initPosition() {
        self.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
       // self.physicsBody?.velocity = CGVector(dx: 312.5, dy: 312.5)
    }
    
    func reset() {
        var restertVelocity = (self.physicsBody?.velocity)!
        restertVelocity.dx = 0
        restertVelocity.dy = 0
        
    }
    @objc func timerUpdate() {
        var newVelocity = (self.physicsBody?.velocity)!
        if newVelocity.dx <= 800{
            newVelocity.dx *= 1.01
        }
        if newVelocity.dy <= 800{
            newVelocity.dy *= 1.01
        }
        self.physicsBody!.velocity = newVelocity
        
        time = time + 1
    }
    
}
