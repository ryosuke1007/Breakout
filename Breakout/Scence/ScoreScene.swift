//
//  ScoreScene.swift
//  Breakout
//
//  Created by 木村　僚介 on 2019/02/23.
//  Copyright © 2019年 木村　僚介. All rights reserved.
//

import SpriteKit
import GameplayKit

class ScoreScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreresult: Int = 0
//    var scoreresult1: Int = 0
//    var scoreresult2: Int = 0
//    var scoreresult3: Int = 0
//    var scoreresult4: Int = 0
//    var scoreresult5: Int = 0
//    var scoreresult6: Int = 0
    var LabelNode: SKLabelNode!
    var scoreresultlabel: SKLabelNode!
    var LabelNode1: SKLabelNode!
    var score1: SKLabelNode!
    var LabelNode2: SKLabelNode!
    var score2: SKLabelNode!
    var LabelNode3: SKLabelNode!
    var score3: SKLabelNode!
    var LabelNode4: SKLabelNode!
    var score4: SKLabelNode!
    var LabelNode5: SKLabelNode!
    var score5: SKLabelNode!
    var LabelNode6: SKLabelNode!
    var score6: SKLabelNode!
    var scoreDate: UserDefaults = UserDefaults.standard
    var rankingArray: [Int]!
    
    func scoretext() {
        scoreresultlabel.text = String(scoreresult)
        //        scoreresult = scoreDate.integer(forKey: "scoreKey")
        score1.text = String(rankingArray[0])
        score2.text = String(rankingArray[1])
        score3.text = String(rankingArray[2])
        score4.text = String(rankingArray[3])
        score5.text = String(rankingArray[4])
        score6.text = String(rankingArray[5])
        
    }
    
    override func didMove(to view: SKView) {
        let rankingData = scoreDate.array(forKey: "rankingArray")
        
        if rankingData != nil {
            rankingArray = rankingData as! [Int]
        }
        
        if rankingArray == nil {
            rankingArray = [0, 0, 0, 0, 0, 0]
        }
        
        
        LabelNode = self.childNode(withName: "LabelNode") as! SKLabelNode
        scoreresultlabel = self.childNode(withName: "scoreresultlabel") as! SKLabelNode
        LabelNode1 = self.childNode(withName: "1LabelNode") as! SKLabelNode
        score1 = self.childNode(withName: "1score") as! SKLabelNode
        LabelNode2 = self.childNode(withName: "2LabelNode") as! SKLabelNode
        score2 = self.childNode(withName: "2score") as! SKLabelNode
        LabelNode3 = self.childNode(withName: "3LabelNode") as! SKLabelNode
        score3 = self.childNode(withName: "3score") as! SKLabelNode
        LabelNode4 = self.childNode(withName: "4LabelNode") as! SKLabelNode
        score4 = self.childNode(withName: "4score") as! SKLabelNode
        LabelNode5 = self.childNode(withName: "5LabelNode") as! SKLabelNode
        score5 = self.childNode(withName: "5score") as! SKLabelNode
        LabelNode6 = self.childNode(withName: "6LabelNode") as! SKLabelNode
        score6 = self.childNode(withName: "6score") as! SKLabelNode
        
        scoreresult = scoreDate.integer(forKey: "scoreKey")
//        scoreresult1 = scoreDate.integer(forKey: "score1")
//        scoreresult2 = scoreDate.integer(forKey: "score2")
//        scoreresult3 = scoreDate.integer(forKey: "score3")
//        scoreresult4 = scoreDate.integer(forKey: "score4")
//        scoreresult5 = scoreDate.integer(forKey: "score5")
//        scoreresult6 = scoreDate.integer(forKey: "score6")
        
        self.rankingUpdate()
        self.scoretext()
        scoreDate.set(rankingArray, forKey: "rankingArray")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let scene = TitleScene(fileNamed: "TitleScene") {
            scene.scaleMode = .aspectFill
            self.view?.presentScene(scene)
        }
    }
    
    
    func rankingUpdate() {
        if scoreresult > rankingArray[0]{
            switchNumber(num: 0)
            rankingArray[0] = scoreresult
        }else if scoreresult > rankingArray[1]{
            switchNumber(num: 1)
            rankingArray[1] = scoreresult
        }else if scoreresult > rankingArray[2]{
            switchNumber(num: 2)
            rankingArray[2] = scoreresult
        }else if scoreresult > rankingArray[3]{
            switchNumber(num: 3)
            rankingArray[3] = scoreresult
        }else if scoreresult > rankingArray[4]{
            switchNumber(num: 4)
            rankingArray[4] = scoreresult
        }else if scoreresult > rankingArray[5]{
            switchNumber(num: 5)
            rankingArray[5] = scoreresult
        }
    }


    func switchNumber(num: Int) {
        for i in (num...4).reversed() {
            rankingArray[i+1] = rankingArray[i]
        }
    }
}
