//
//  Player.swift
//  ArcadeGameTemplate
//
//  Created by Micaela Giannetti on 12/12/23.
//

import Foundation
import SpriteKit

class Player : SKSpriteNode{
    var initialSize : CGSize = CGSize(width: 48, height: 56)
    var textureAtlas : SKTextureAtlas = SKTextureAtlas(named: "RunningPlayer")
    var runAnimation = SKAction()
    var jumpAnimation = SKAction()
    var jumping = false
    let maxJumpingForce : CGFloat = 57000
    let maxHeight: CGFloat = 1000
 
    
    init(){
        super.init(texture:nil, color:.clear, size:initialSize)
        createAnimations()
        self.run(runAnimation, withKey: "runningAnimation")
        let bodyTexture = textureAtlas.textureNamed("player1")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: self.size)
        self.physicsBody?.mass = 30
        self.physicsBody?.allowsRotation = false
        
    }
    func createAnimations() {
        let runFrames: [SKTexture] =
        [textureAtlas.textureNamed("player1"),
         textureAtlas.textureNamed("player2")]
        let runAction = SKAction.animate(with: runFrames, timePerFrame: 0.14)
        runAnimation = SKAction.repeatForever(runAction)
        let jumpFrames: [SKTexture] =
        [textureAtlas.textureNamed("player-jump")]
        let jumpAction = SKAction.animate(with: jumpFrames, timePerFrame: 1)
        jumpAnimation = SKAction.repeatForever(jumpAction)
        
        
    }
    
    func RunningPlayer () {
        let moveRight = SKAction.moveBy(x:size.width, y:0, duration: 0.5)
        let neverEndingRun = SKAction.repeatForever(moveRight)
        self.run(neverEndingRun)
    }
    
    func update(){
        self.physicsBody?.applyForce(CGVector (dx:0, dy:500))
    }
    
    required init? (coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
    }
}
