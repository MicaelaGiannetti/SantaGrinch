//
//  Gifts.swift
//  ArcadeGameTemplate
//
//  Created by Micaela Giannetti on 15/12/23.
//

import Foundation
import SpriteKit

class Gifts : SKSpriteNode {
    var initialSize = CGSize (width: 40, height: 60)
    var textureAtlas : SKTextureAtlas =
    SKTextureAtlas(named: "Gifts")
    var pulseAnimation = SKAction()
    
    
    init(){
        let giftTexture = textureAtlas.textureNamed("gift")
        super.init(texture: giftTexture, color:.clear, size:initialSize)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 40, height: 60))
        self.physicsBody?.affectedByGravity=false
        createAnimations()
        self.run(pulseAnimation)
        self.physicsBody?.categoryBitMask = 32
     //   self.physicsBody?.contactTestBitMask = 1 | 16
        self.physicsBody?.collisionBitMask = 0
        self.name = "gift"
    }
    
    func createAnimations(){
     
        let pulseOutGroup = SKAction.group([
            SKAction.fadeAlpha(to: 0.85, duration: 0.8),
            SKAction.scale(to: 0.6, duration: 1.5),
            SKAction.rotate(byAngle: -0.3, duration: 0.8)
        ])
        let pulseInGroup = SKAction.group([
            SKAction.fadeAlpha(by: 1, duration: 1.5),
            SKAction.scale(to: 1, duration: 1.5),
            SKAction.rotate(byAngle: 3.5, duration: 1.5)
        ])
        let pulseSequence = SKAction.sequence([pulseOutGroup,pulseInGroup])
        pulseAnimation = SKAction.repeatForever(pulseSequence)
    }
    func collect () {
        self.physicsBody?.categoryBitMask = 0
        print ("GIFT")
        print (self.position)
        self.alpha = 0
      /*  let collectAnimation = SKAction.group([SKAction.fadeAlpha(to: 0, duration: 0.2),
                                               SKAction.scale(to: 1.5, duration: 0.2),
                                               SKAction.move(by: CGVector(dx: 0, dy: 25), duration: 0.2)])
        let resetAfterCollected = SKAction.run{
            self.position.y = 300
            self.alpha = 1
            self.xScale = 1
            self.yScale = 1
            self.physicsBody?.categoryBitMask = 32
        }
        let collectSequence = SKAction.sequence([
        collectAnimation, resetAfterCollected])
        self.run(collectSequence) */
        
        
    }
    required init? (coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
}
