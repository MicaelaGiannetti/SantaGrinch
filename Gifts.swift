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
    required init? (coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
}
