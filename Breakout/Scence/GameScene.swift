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
    let scoreDate: UserDefaults = UserDefaults.standard
    // var ball: SKSpriteNode!
    var paddle: SKSpriteNode!
    var time: Int = 0
    var count: Int = 0
    var isGameover: Int = 0
    var score: Int = 0
    var startDate = NSDate()
    var bricks: [SKNode] = []
    var scorelabel: SKLabelNode!
    var gameoverlabel: SKLabelNode!
    var messagelabel: SKLabelNode!
    var gamescorelabel: SKLabelNode!
    var objectiveBall: Ball!
    var secondBall: Ball!
    var thirdBall: Ball!
    
    func gameover() {
        if isGameover == 0 {
            //            gameoverlabel.text = "GAMEOVER"
            //            messagelabel.text = "Your score is"
            //            gamescorelabel.text = String(score)
            scoreDate.set(score, forKey: "scoreKey")
            if let scene = ScoreScene(fileNamed: "ScoreScene") {
                scene.scaleMode = .aspectFill
                self.view?.presentScene(scene)
            }
            //            count = 0
            //            score = 0
            //            objectiveBall.reset()
            //            for Brick in bricks {
            //                Brick.removeFromParent() }
        }
    }
    
    
    override func didMove(to view: SKView) {
        
        //ここの二行で1個目のボールセットアップ
        objectiveBall = self.childNode(withName: "Ball") as? Ball!
        objectiveBall.setUp()
        
        //ここで二個目のボールだけを定義
        secondBall = self.childNode(withName: "SecondBall") as? Ball!
        thirdBall = self.childNode(withName: "ThirdBall") as? Ball!
        //ボールを見えないように設定
        secondBall.isHidden = true
        thirdBall.isHidden = true
        
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
        isGameover = isGameover + 1
        scorelabel.text = String(score)
        
        self.scaleMode = .aspectFit
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
            
            if isGameover == 0 {
                if let scene = GameScene(fileNamed: "GameScene") {
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                }
                //                objectiveBall.positionSet(x: touchLocation.x, y: -450)
                //                self.addChild(objectiveBall!)
                //                //ここで二個目のボールだけを定義
                //                secondBall.positionSet(x: 0, y: -450)
                //                self.addChild(secondBall!)
                //                secondBall.isHidden = false
                //                score = 0
                //                objectiveBall.initPosition()
                //                gameoverlabel.text = ""
                //                messagelabel.text = ""
                //                gamescorelabel.text = ""
                //                for Brick in bricks {
                //                    self.addChild(Brick)
                //                }
                //                isGameover = 2
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
                isGameover = isGameover - 1
                contact.bodyA.node?.removeFromParent()
                let particle = SKEmitterNode(fileNamed: "spark.sks" )
                particle!.position = CGPoint(x:contact.contactPoint.x, y:contact.contactPoint.y)
                let action1 = SKAction.wait(forDuration: 0.5)
                let action2 = SKAction.removeFromParent()
                let actionAll = SKAction.sequence([action1, action2])
                self.addChild(particle!)
                particle!.run(actionAll)
                self.gameover()
                
            } else if bodyBName == "Ball" {
                isGameover = isGameover - 1
                contact.bodyB.node?.removeFromParent()
                let particle = SKEmitterNode(fileNamed: "spark.sks" )
                particle!.position = CGPoint(x:contact.contactPoint.x, y:contact.contactPoint.y)
                let action1 = SKAction.wait(forDuration: 0.5)
                let action2 = SKAction.removeFromParent()
                let actionAll = SKAction.sequence([action1, action2])
                self.addChild(particle!)
                particle!.run(actionAll)
                self.gameover()
            }
        }
        
        if bodyAName == "Wall" && bodyBName == "SecondBall" || bodyAName == "SecondBall" && bodyBName == "Wall"{
            if bodyAName == "SecondBall" {
                isGameover = isGameover - 1
                contact.bodyA.node?.removeFromParent()
                let particle = SKEmitterNode(fileNamed: "spark.sks" )
                particle!.position = CGPoint(x:contact.contactPoint.x, y:contact.contactPoint.y)
                let action1 = SKAction.wait(forDuration: 0.5)
                let action2 = SKAction.removeFromParent()
                let actionAll = SKAction.sequence([action1, action2])
                self.addChild(particle!)
                particle!.run(actionAll)
                self.gameover()
                
            } else if bodyBName == "SecondBall" {
                isGameover = isGameover - 1
                contact.bodyB.node?.removeFromParent()
                let particle = SKEmitterNode(fileNamed: "spark.sks" )
                particle!.position = CGPoint(x:contact.contactPoint.x, y:contact.contactPoint.y)
                let action1 = SKAction.wait(forDuration: 0.5)
                let action2 = SKAction.removeFromParent()
                let actionAll = SKAction.sequence([action1, action2])
                self.addChild(particle!)
                particle!.run(actionAll)
                self.gameover()
            }
        }
        
        if bodyAName == "Wall" && bodyBName == "ThirdBall" || bodyAName == "ThirdBall" && bodyBName == "Wall"{
            if bodyAName == "ThirdBall" {
                isGameover = isGameover - 1
                contact.bodyA.node?.removeFromParent()
                let particle = SKEmitterNode(fileNamed: "spark.sks" )
                particle!.position = CGPoint(x:contact.contactPoint.x, y:contact.contactPoint.y)
                let action1 = SKAction.wait(forDuration: 0.5)
                let action2 = SKAction.removeFromParent()
                let actionAll = SKAction.sequence([action1, action2])
                self.addChild(particle!)
                particle!.run(actionAll)
                self.gameover()
                
            } else if bodyBName == "ThirdBall" {
                isGameover = isGameover - 1
                contact.bodyB.node?.removeFromParent()
                let particle = SKEmitterNode(fileNamed: "spark.sks" )
                particle!.position = CGPoint(x:contact.contactPoint.x, y:contact.contactPoint.y)
                let action1 = SKAction.wait(forDuration: 0.5)
                let action2 = SKAction.removeFromParent()
                let actionAll = SKAction.sequence([action1, action2])
                self.addChild(particle!)
                particle!.run(actionAll)
                self.gameover()
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
        
        if bodyAName == "SecondBall" && bodyBName == "Brick" || bodyAName == "Brick" && bodyBName == "SecondBall"{
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
        
        if bodyAName == "ThirdBall" && bodyBName == "Brick" || bodyAName == "Brick" && bodyBName == "ThirdBall"{
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
            if score >= 450 {
                if secondBall.isHidden == true {
                    if isGameover == 1 {
                        //ボールが見えるようになった
                        secondBall.isHidden = false
                        secondBall.setUp()
                        secondBall.positionSet(x: 0, y: -400)
                        isGameover = isGameover + 1
                    }
                }
            }
            if score >= 900 {
                if thirdBall.isHidden == true {
                    if isGameover == 2 {
                        //ボールが見えるようになった
                        thirdBall.isHidden = false
                        thirdBall.setUp()
                        thirdBall.positionSet(x: 0, y: -400)
                        isGameover = isGameover + 1
                    }
                }
            }
        }
        
        if bodyAName == "Paddle" && bodyBName == "SecondBall" || bodyAName == "SecondBall" && bodyBName == "Paddle" {
            if count >= 9 {
                for Brick in bricks {
                    self.addChild(Brick)
                    count = 0
                }
            }
        }
    }
}

