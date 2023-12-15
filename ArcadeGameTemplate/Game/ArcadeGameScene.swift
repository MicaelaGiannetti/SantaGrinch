//
//  ArcadeGameScene.swift
//  ArcadeGameTemplate
//

import SpriteKit
import SwiftUI

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Player: UInt32 = 0b1
    static let Ground: UInt32 = 0b10
}

class ArcadeGameScene: SKScene, SKPhysicsContactDelegate {
    /**
     * # The Game Logic
     *     The game logic keeps track of the game variables
     *   you can use it to display information on the SwiftUI view,
     *   for example, and comunicate with the Game Scene.
     **/
    var gameLogic: ArcadeGameLogic = ArcadeGameLogic.shared
    
    // Keeps track of when the last update happend.
    // Used to calculate how much time has passed between updates.
    var lastUpdate: TimeInterval = 0
    let cam = SKCameraNode()
    let ground = Ground()
   let player = Player()
    
    
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = .zero
        self.backgroundColor = UIColor(red:0.4, green:0.6, blue:0.95, alpha:1.0)
        self.camera = cam
        player.position = CGPoint (x:150, y:250)
        self.addChild(player)
        player.RunningPlayer()
        ground.position = CGPoint (x: -self.size.width * 2, y: 30)
        ground.size = CGSize (width: self.size.width * 6, height: 0)
        ground.createChildren()
        
        self.addChild(ground)
        
        self.setUpGame()
        self.physicsWorld.contactDelegate = self
     //   self.setUpPhysicsWorld()
        
        
    }
    func didBegin(_ contact: SKPhysicsContact){
        if contact.bodyA.categoryBitMask == 0b1 && contact.bodyB.categoryBitMask == 0b10 {
            player.playerInAir = false
            player.jumpCount = 0
        }
     /*   if (contact.bodyA.categoryBitMask & playerMask) > 0 {
            
        }*/
    }
    
    //Keep camera on player
    
    override func didSimulatePhysics() {
        self.camera!.position.x = player.position.x
        self.camera!.position.y = 170
    }
    
   
    
    override func update(_ currentTime: TimeInterval) {
        
    
        // ...
        
        // If the game over condition is met, the game will finish
        if self.isGameOver { self.finishGame() }
        
        // The first time the update function is called we must initialize the
        // lastUpdate variable
        if self.lastUpdate == 0 { self.lastUpdate = currentTime }
        
        // Calculates how much time has passed since the last update
        let timeElapsedSinceLastUpdate = currentTime - self.lastUpdate
        // Increments the length of the game session at the game logic
    //    self.gameLogic.increaseSessionTime(by: timeElapsedSinceLastUpdate)
        
        self.lastUpdate = currentTime
    }
    
}

// MARK: - Game Scene Set Up
extension ArcadeGameScene {
    
    private func setUpGame() {
        self.gameLogic.setUpGame()
        
        // TODO: Customize!
    }
    
    private func setUpPhysicsWorld() {
        // TODO: Customize!
       
        
    }
    
    private func restartGame() {
        self.gameLogic.restartGame()
    }
}


// MARK: - Handle Player Inputs
extension ArcadeGameScene {
    
    //TODO: Add comment here
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // TODO: Customize!
        if player.jumpCount < 3 {
            player.isJumping(tapPos: (touches.first!.location(in: self.view)))
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: Customize!
        for touch in touches {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: Customize!
        player.stopJumping()
    }
    
}


// MARK: - Game Over Condition
extension ArcadeGameScene {
    
    /**
     * Implement the Game Over condition.
     * Remember that an arcade game always ends! How will the player eventually lose?
     *
     * Some examples of game over conditions are:
     * - The time is over!
     * - The player health is depleated!
     * - The enemies have completed their goal!
     * - The screen is full!
     **/
    
    var isGameOver: Bool {
        // TODO: Customize!
        
        // Did you reach the time limit?
        // Are the health points depleted?
        // Did an enemy cross a position it should not have crossed?
        
        return gameLogic.isGameOver
    }
    
    private func finishGame() {
        
        // TODO: Customize!
        
        gameLogic.isGameOver = true
    }
    
}

// MARK: - Register Score
extension ArcadeGameScene {
    
    private func registerScore() {
        // TODO: Customize!
    }
    
}
