//
//  GameScene.swift
//  Breakout
//
//  Created by 木村　僚介 on 2018/03/03.
//  Copyright © 2018年 木村　僚介. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    var ball:SKSpriteNode!
    var paddle: SKSpriteNode!
    var time: Int = 0
    var count: Int = 0
    var isGameover: Bool = false
    var score: Int = 0
    var startDate = NSDate()
    var bricks: [SKNode] = []
    var scorelabel: SKLabelNode!
    var gameoverlabel: SKLabelNode!
    var messagelabel: SKLabelNode!
    var gamescorelabel: SKLabelNode!
    
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(GameScene.timerUpdate), userInfo: nil, repeats: true)
        ball = self.childNode(withName: "Ball") as! SKSpriteNode
        ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
        paddle = self.childNode(withName: "Paddle") as! SKSpriteNode
        scorelabel = self.childNode(withName: "Label") as! SKLabelNode
        gameoverlabel = self.childNode(withName: "gameoverlabel") as! SKLabelNode
        messagelabel = self.childNode(withName: "messagelabel") as! SKLabelNode
        gamescorelabel = self.childNode(withName: "gamescorelabel") as! SKLabelNode
        
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 0
        self.physicsBody = border
        
        self.physicsWorld.contactDelegate = self //ボールの衝突時の判定をここでする
        
        for child in children {
            if child.name == "Brick" {
                bricks.append(child)
            }
        }
        
        scorelabel.text = String(score)
    }
    
    @objc func timerUpdate() {
        if isGameover {
            return
        }
        var newvelocity = (ball.physicsBody?.velocity)!
        if newvelocity.dx <= 800{
            newvelocity.dx *= 1.0001
        }
        if newvelocity.dy <= 800{
            newvelocity.dy *= 1.0001
        }
        ball.physicsBody?.velocity = newvelocity
        time = time + 1
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
            
            if isGameover == true {
                ball.position.x = touchLocation.x
                ball.position.y = -450
                self.addChild(ball)
                score = 0
//                ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
                ball.physicsBody?.velocity = CGVector(dx: 312.5, dy: 312.5)
                scorelabel.text = String(score)
                gameoverlabel.text = ""
                messagelabel.text = ""
                gamescorelabel.text = ""
                    for Brick in bricks {
                        self.addChild(Brick)
                    }
                isGameover = false
                
                
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
        }
    }
    
    
    
    func didBegin (_ contact: SKPhysicsContact) {
        let bodyAName = contact.bodyA.node?.name
        let bodyBName = contact.bodyB.node?.name
        
        if bodyAName == "Wall" && bodyBName == "Ball" || bodyAName == "Ball" && bodyBName == "Wall"{
            if bodyAName == "Ball" {
                contact.bodyA.node?.removeFromParent()
                let particle = SKEmitterNode(fileNamed: "spark.sks" )
                particle!.position = CGPoint(x:contact.contactPoint.x, y:contact.contactPoint.y)
                let action1 = SKAction.wait(forDuration: 0.5)
                let action2 = SKAction.removeFromParent()
                let actionAll = SKAction.sequence([action1, action2])
                self.addChild(particle!)
                particle!.run(actionAll)
                gameoverlabel.text = "GAMEOVER"
                messagelabel.text = "Your score is"
                gamescorelabel.text = String(score)
                count = 0
                for Brick in bricks {
                    Brick.removeFromParent()
                }
                isGameover = true
                
            } else if bodyBName == "Ball" {
                contact.bodyB.node?.removeFromParent()
                let particle = SKEmitterNode(fileNamed: "spark.sks" )
                particle!.position = CGPoint(x:contact.contactPoint.x, y:contact.contactPoint.y)
                let action1 = SKAction.wait(forDuration: 0.5)
                let action2 = SKAction.removeFromParent()
                let actionAll = SKAction.sequence([action1, action2])
                self.addChild(particle!)
                particle!.run(actionAll)
                gameoverlabel.text = "GAMEOVER"
                messagelabel.text = "Your score is"
                gamescorelabel.text = String(score)
                count = 0
                for Brick in bricks {
                    Brick.removeFromParent()
                }
                isGameover = true
                
            }
        }
        
        
        if bodyAName == "Ball" && bodyBName == "Brick" || bodyAName == "Brick" && bodyBName == "Ball"{
            if bodyAName == "Brick" {
                contact.bodyA.node?.removeFromParent()
                count = count + 1
                score = score + 50
                scorelabel.text = String(score)
                let particle = SKEmitterNode(fileNamed: "spark.sks" )
                particle!.position = (contact.bodyA.node?.position)!;
                let action1 = SKAction.wait(forDuration: 0.3)
                let action2 = SKAction.removeFromParent()
                let actionAll = SKAction.sequence([action1, action2])
                self.addChild(particle!)
                particle!.run(actionAll)
            } else if bodyBName == "Brick" {
                contact.bodyB.node?.removeFromParent()
                count = count + 1
                score = score + 50
                scorelabel.text = String(score)
                let particle = SKEmitterNode(fileNamed: "spark.sks" )
                particle!.position = (contact.bodyB.node?.position)!;
                let action1 = SKAction.wait(forDuration: 0.3)
                let action2 = SKAction.removeFromParent()
                let actionAll = SKAction.sequence([action1, action2])
                self.addChild(particle!)
                particle!.run(actionAll)
            }
        }
        
        if bodyAName == "Paddle" && bodyBName == "Ball" || bodyAName == "Ball" && bodyBName == "Paddle" {
            if count >= 9 {
                for Brick in bricks {
                    self.addChild(Brick)
                    count = 0
                }
            }
        }
    }
}

