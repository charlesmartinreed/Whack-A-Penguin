//
//  WhackSlot.swift
//  Project14
//
//  Created by Charles Martin Reed on 8/22/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit
import SpriteKit

//SKNode is the base class that subclasses like SKSpriteNode, SKEmitterNode, SKLabelNode, etc. extend. It simply sits at a position in our scene and holds child nodes.
class WhackSlot: SKNode {
    //if you don't create any inits or required inits and don't use any non-optional properties, Swift will use the parent class's init methods
    
    func configure(at position: CGPoint) {
        self.position = position
        
        let sprite = SKSpriteNode(imageNamed: "whackHole.png")
        addChild(sprite)
        
        //creating our SKCropNode for our penguin
        //gives us a crop mask - anything in the colored space is masked, anything in the transparent space is visible. The crop mask will be shaped like the hole the penguin is supposed to emerge from.
        let cropNode = SKCropNode()
        //Per Paul, 15 is the exact number needed to make the crop line up with the hole's graphics
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        //notice that the penguin is the child node of our cropNode
        //cropNode ONLY hides things that are inside of it, so charNode must be child
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        //since this position is relative to the parent node, this means the penguin is -90 beneath the crop at start
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        
        //and then we add the cropNode as a child of our WhackSlot
        addChild(cropNode)
    }

}
