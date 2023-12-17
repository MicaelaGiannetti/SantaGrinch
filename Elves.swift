//
//  Elves.swift
//  ArcadeGameTemplate
//
//  Created by Micaela Giannetti on 15/12/23.
//

import Foundation
import SpriteKit

class Elves : SKSpriteNode {
    var initialSize = CGSize (width: 80, height: 60)
    var textureAtlas : SKTextureAtlas =
    SKTextureAtlas(named: "Elves")
    var elfAnimation = SKAction()

    
    init(){
        
        super.init(texture:nil, color:.clear, size:initialSize)
        self.name = "elf"
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        self.physicsBody?.mass = 100
        self.physicsBody?.affectedByGravity = true
        createAnimations()
        self.run (elfAnimation)
        self.physicsBody?.categoryBitMask = 4
        self.physicsBody?.collisionBitMask = ~16
    }
    
    func createAnimations() {
        let elfFrames : [SKTexture] = [
            textureAtlas.textureNamed("elf1"),
            textureAtlas.textureNamed("elf2")]
        let elfAction = SKAction.animate(with:elfFrames,timePerFrame: 0.12)
        elfAnimation = SKAction.repeatForever(elfAction)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
