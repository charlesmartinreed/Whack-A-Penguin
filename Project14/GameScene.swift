//
//  GameScene.swift
//  Project14
//
//  Created by Charles Martin Reed on 8/22/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
   
    //this array will hold our slots
    var slots = [WhackSlot]()
    
    var gameScore: SKLabelNode!
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    //this is where we'll store the penguin node
    var charNode: SKSpriteNode!
    
    //we'll use this to vary how quickly penguins appear visible
    var popupTime = 0.85
    
    override func didMove(to view: SKView) {
        //adding our background for the game level
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        //designing and placing our gameScore label
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.fontSize = 48
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        addChild(gameScore)
        
        //using a for-loop to place slots at specific locations on screen
        //higher Y values mean closer to the top of the screen in SpriteKit
        for i in 0..<5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 410))}
        for i in 0..<4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 320))}
        for i in 0..<5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 230))}
        for i in 0..<4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 140))}
        
        //after a brief delay to allow the user to orient themselves, we start creating penguins
        //asyncAfter means "1 second after our deadline, in this case "now"
//        DispatchQueue.main.asyncAfter(deadline: .now()) {
//            [unowned self] in
//            self.doStuff()
//        }
        
        //triggering our call createEnemy - keep in mind this function calls itself once this initial call is completed
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            [unowned self] in
            self.createEnemy()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //stuff
    }
    
    //MARK: - createSlot()
    func createSlot(at position: CGPoint) {
        //method accepts position, creates a WhackSlot object and calls the configure method before adding the slot to the scene AND the array
        
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
    
    //MARK: - createEnemy()
    func createEnemy() {
        //decreasing the popupTime by a fraction each time this is run
        popupTime *= 0.991
        
        slots = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: slots) as! [WhackSlot]
        slots[0].show(hideTime: popupTime)
        
        //using a random int to decide which of the shuffled array items to use for placing our game sprites after our initial one is shown.
        if RandomInt(min: 0, max: 12) > 4 { slots[1].show(hideTime: popupTime) }
        if RandomInt(min: 0, max: 12) > 8 { slots[2].show(hideTime: popupTime) }
        if RandomInt(min: 0, max: 12) > 10 { slots[3].show(hideTime: popupTime) }
        if RandomInt(min: 0, max: 12) > 11 { slots[4].show(hideTime: popupTime) }
        
        let minDelay = popupTime / 2.0
        let maxDelay = popupTime * 2
        let delay = RandomDouble(min: minDelay, max: maxDelay)
        
        //this allows our createEnemy func to call itself after a random period of time from the present until the game is done
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            [unowned self] in
            self.createEnemy()
        }
    }
}
