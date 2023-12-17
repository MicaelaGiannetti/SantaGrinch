//
//  Player.swift
//  ArcadeGameTemplate
//
//  Created by Micaela Giannetti on 12/12/23.
//

import Foundation
import SpriteKit

class Player : SKSpriteNode{
    var initialSize : CGSize = CGSize(width: 80, height: 120)
    var textureAtlas : SKTextureAtlas = SKTextureAtlas(named: "RunningPlayer")
    var runAnimation = SKAction()
    var jumpAnimation = SKAction()
    var jumping = false
    var playerInAir = false
    var jumpCount = 0
    var health : Int = 3
    var invulnerable = false
    var damaged = false
    var damageAnimation = SKAction()
    var damageImageAnimation = SKAction()
    var dieAnimation = SKAction()
    var forwardVelocity : CGFloat = 200
    
    
 
    
    init(){
        super.init(texture:nil, color:.clear, size:initialSize)
        createAnimations()
        self.run(runAnimation, withKey: "runningAnimation")
        //let bodyTexture = textureAtlas.textureNamed("player1")
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 115))
        self.physicsBody?.mass = 1
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.contactTestBitMask = 2 | 4 | 8 | 32
        self.physicsBody?.collisionBitMask = 2 | 4
        self.name = "player"
        
        
    }
    func createAnimations() {
        let runFrames: [SKTexture] =
        [textureAtlas.textureNamed("player1"),
         textureAtlas.textureNamed("player2"),
         textureAtlas.textureNamed("player3"),
         textureAtlas.textureNamed("player4"),
        ]
        
        let runAction = SKAction.animate(with: runFrames, timePerFrame: 0.1)
        runAnimation = SKAction.repeatForever(runAction)
        let jumpFrames: [SKTexture] =
        [textureAtlas.textureNamed("player-jump")]
        let jumpAction = SKAction.animate(with: jumpFrames, timePerFrame: 1)
        jumpAnimation = SKAction.repeatForever(jumpAction)
        
        let damageStart = SKAction.run {
            self.physicsBody?.categoryBitMask = 16
            }
        let damageFrames : [SKTexture] =
        [textureAtlas.textureNamed("playerDamaged")]
        let damageAction = SKAction.animate(with: damageFrames, timePerFrame: 1)
        damageImageAnimation = SKAction.repeatForever(damageAction)
        
       
        let slowFade = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.3, duration: 0.35),
            SKAction.fadeAlpha(to: 0.7, duration: 0.35)])
        let fastFade = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.3, duration: 0.2),
            SKAction.fadeAlpha(to: 0.7, duration: 0.2)])
        let fadeOutAndIn = SKAction.sequence([
            SKAction.repeat(slowFade, count: 2),
            SKAction.repeat(fastFade, count: 5),
            SKAction.fadeAlpha(to: 1, duration: 0.15)])
        let damageEnd = SKAction.run {
            self.physicsBody?.categoryBitMask = 1
            self.damaged = false
            self.run(self.runAnimation)
        }
        self.damageAnimation = SKAction.sequence([
        damageStart, fadeOutAndIn, damageEnd])
        
        let dieFrames : [SKTexture] =
        [textureAtlas.textureNamed("playerDead1"),
         textureAtlas.textureNamed("playerDead2")]
        let dieAction = SKAction.animate(with: dieFrames, timePerFrame: 0.3)
        dieAnimation = SKAction.repeatForever(dieAction)
        
        
    }
    
    func RunningPlayer () {
        
     /*   let moveRight = SKAction.moveBy(x:size.width, y:0, duration: 0.5)
        let neverEndingRun = SKAction.repeatForever(moveRight)
        self.run(neverEndingRun) */
    }
    
    func isJumping() {
        playerInAir = true
        jumpCount += 1
        startJumping()
        self.physicsBody?.velocity = CGVector.zero
        self.physicsBody?.applyImpulse(CGVector (dx:0, dy:700))
       /* let jumpUp = SKAction.moveTo(y: 200, duration: 0.6)
        let jumpDown = SKAction.moveTo(y: 60, duration: 1)
        self.run(SKAction.sequence([jumpUp,jumpDown]), withKey: "Jump") */
            
        
    }
    
    func update(){
        self.physicsBody?.velocity.dx = forwardVelocity
        }
            
        /*    let jumpUp = SKAction.moveTo(y: 300, duration: 0.3)
            let jumpDown = SKAction.moveTo(y: 250, duration: 0.3)
            self.run(SKAction.sequence([jumpUp,jumpDown]), withKey: "Jump")
            self.run(jumpAnimation) */
        
    
    
    func startJumping(){
        if self.health <= 0 {return}
        self.removeAction(forKey: "runningAnimation")
        self.run(jumpAnimation, withKey: "jumpingAnimation")
            self.jumping = true
        
    }
    
    func stopJumping() {
        if self.health <= 0 {return}
            self.removeAction(forKey: "jumpingAnimation")
            self.run(runAnimation, withKey: "runningAnimation")
            self.jumping = false
    }
    
    func die () {
        self.alpha = 1
        self.removeAllActions()
        self.run (self.dieAnimation)
        self.playerInAir = false
        self.forwardVelocity = 0
        
    }
    
    func takeDamage(){
        if self.invulnerable || self.damaged {return}
        self.damaged = true
        self.health -= 1
        if self.health == 0 {
            die()
        }
        else {
            self.run(self.damageAnimation)
            self.run(self.damageImageAnimation)
        }
        
    }
    required init? (coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
    }
}
