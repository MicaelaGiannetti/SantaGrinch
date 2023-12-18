//
//  Elves.swift
//  ArcadeGameTemplate
//
//  Created by Micaela Giannetti on 15/12/23.
//

import Foundation
import SpriteKit

class Elves : SKSpriteNode {
    var initialSize = CGSize (width: 50, height: 90)
    var textureAtlas : SKTextureAtlas =
    SKTextureAtlas(named: "Elves")
    var elfAnimation = SKAction()

    
    init(){
        
        super.init(texture:nil, color:.clear, size:initialSize)
        self.name = "elf"
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 80))
        self.physicsBody?.mass = 100
        self.physicsBody?.affectedByGravity = true
        createAnimations()
        self.run (elfAnimation)
        self.physicsBody?.categoryBitMask = 4
        self.physicsBody?.collisionBitMask = 1 | 2 
    }
    
    func createAnimations() {
        let elfFrames : [SKTexture] = [
            textureAtlas.textureNamed("elf1"),
            textureAtlas.textureNamed("elf2"),
            textureAtlas.textureNamed("elf3"),
            textureAtlas.textureNamed("elf4"),
            textureAtlas.textureNamed("elf5"),]
        let elfAction = SKAction.animate(with:elfFrames,timePerFrame: 0.12)
        elfAnimation = SKAction.repeatForever(elfAction)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
