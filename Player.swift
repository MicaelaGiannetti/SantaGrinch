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
    var playerInAir = false
    var jumpCount = 0
    
 
    
    init(){
        super.init(texture:nil, color:.clear, size:initialSize)
        createAnimations()
        self.run(runAnimation, withKey: "runningAnimation")
        let bodyTexture = textureAtlas.textureNamed("player1")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: self.size)
        self.physicsBody?.mass = 1
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.contactTestBitMask = 2 | 4 | 8
        self.physicsBody?.collisionBitMask = 2 | 4
        
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
    
    func isJumping() {
        playerInAir = true
        jumpCount += 1
        startJumping()
      //  self.physicsBody?.velocity = CGVector.zero
        self.physicsBody?.applyImpulse(CGVector (dx:0, dy:700))
       /* let jumpUp = SKAction.moveTo(y: 200, duration: 0.6)
        let jumpDown = SKAction.moveTo(y: 60, duration: 1)
        self.run(SKAction.sequence([jumpUp,jumpDown]), withKey: "Jump") */
            
        
    }
    
    func update(){
        
        }
            
        /*    let jumpUp = SKAction.moveTo(y: 300, duration: 0.3)
            let jumpDown = SKAction.moveTo(y: 250, duration: 0.3)
            self.run(SKAction.sequence([jumpUp,jumpDown]), withKey: "Jump")
            self.run(jumpAnimation) */
        
    
    
    func startJumping(){
        self.removeAction(forKey: "runningAnimation")
        self.run(jumpAnimation, withKey: "jumpingAnimation")
            self.jumping = true
    }
    
    func stopJumping() {
            self.removeAction(forKey: "jumpingAnimation")
            self.run(runAnimation, withKey: "runningAnimation")
            self.jumping = false
    }
    required init? (coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
    }
}
