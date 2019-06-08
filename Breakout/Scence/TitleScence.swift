//
//  TitleScence.swift
//  Breakout
//
//  Created by 木村　僚介 on 2018/12/15.
//  Copyright © 2018年 木村　僚介. All rights reserved.
//

import SpriteKit
import GameplayKit

class TitleScene: SKScene, SKPhysicsContactDelegate {
    
    var startButton: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        startButton = self.childNode(withName: "StartButton") as! SKNode as! SKLabelNode
        startButton.position = CGPoint(x: 0/2, y: -self.frame.height/4)
        startButton.zPosition = 1
        startButton.name = "Start"
        //        self.addChild(startButton)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            let location = touch.location(in: self)
            if self.atPoint(location).name == "Start" {
                print("move")
                //                scene == GameScene(size: self.scene!.size)
                //                scene?.scaleMode = SKSceneScaleMode.aspectFill
                //                self.view!.presentScene(scene)
            }
            
            if let scene = GameScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                self.view?.presentScene(scene)
            }
        }
    }
}
