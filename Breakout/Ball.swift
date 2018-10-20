////
////  Ball.swift
////  Breakout
////
////  Created by 木村　僚介 on 2018/10/20.
////  Copyright © 2018年 木村　僚介. All rights reserved.
////
//
//import Foundation
//import GameplayKit
//
//class Ball: SKScene {
//    var ball:SKSpriteNode!
//    
//    init(ball: SKSpriteNode) {
//        super.init()
//        self.ball = ball
//        self.ball = childNode(withName: "Ball") as! SKSpriteNode
//        self.ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//
