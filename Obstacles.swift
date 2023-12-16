//
//  Obstacles.swift
//  ArcadeGameTemplate
//
//  Created by Micaela Giannetti on 15/12/23.
//

import Foundation
import SpriteKit

class Obstacles : SKSpriteNode {
    var initialSize = CGSize (width: 100, height: 100)
    var textureAtlas : SKTextureAtlas =
    SKTextureAtlas(named: "Obstacles")
    var lightAnimation = SKAction()
    
    init() {
        super.init(texture:nil, color:.clear, size: initialSize)
        self.physicsBody = SKPhysicsBody (texture: textureAtlas.textureNamed("obstacle1"), size: initialSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = 2
        createAnimations()
        self.run(lightAnimation)
    }
    func createAnimations(){
        let lightFrames: [SKTexture] = [
            textureAtlas.textureNamed("obstacle1"),
            textureAtlas.textureNamed("obstacle2")]
        let lightAction = SKAction.animate(with: lightFrames, timePerFrame: 0.07)
        lightAnimation = SKAction.repeatForever(lightAction)
    }
    required init?(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
    }
}
