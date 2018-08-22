//
//  GameScene.swift
//  Project14
//
//  Created by Charles Martin Reed on 8/22/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import SpriteKit

var gameScore: SKLabelNode!
var score = 0 {
    didSet {
        gameScore.text = "Score: \(score)"
    }
}

//this array will hold our slots
var slots = [WhackSlot]()

//this is where we'll store the penguin node
var charNode: SKSpriteNode!


class GameScene: SKScene {
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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //stuff
    }
    
    func createSlot(at position: CGPoint) {
        //method accepts position, creates a WhackSlot object and calls the configure method before adding the slot to the scene AND the array
        
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
   
}
