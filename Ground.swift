//
//  Ground.swift
//  ArcadeGameTemplate
//
//  Created by Micaela Giannetti on 12/12/23.
//

import Foundation
import SpriteKit

class Ground : SKSpriteNode{
    var jumpWidth = CGFloat()
    var jumpCount = CGFloat(1)
    
    func setUpGround () {
     /*   self.physicsBody?.categoryBitMask = 0b10
        self.physicsBody?.collisionBitMask = 0b1
        self.physicsBody?.contactTestBitMask = 0b1 */
    }
    var textureAtlas: SKTextureAtlas =
    SKTextureAtlas(named:"Environment-ground")
    func createChildren(){
        self.anchorPoint = CGPoint (x:0,y:1)
        let texture = textureAtlas.textureNamed("tundra")
        var tileCount : CGFloat = 0
        let tileSize = CGSize (width: 70, height: 70)
        
        while tileCount * tileSize.width<self.size.width{
            let tileNode = SKSpriteNode(texture:texture)
            tileNode.size = tileSize
            tileNode.position.x = tileCount * tileSize.width
            tileNode.zPosition = 1.0
            tileNode.anchorPoint = CGPoint (x:0,y:1)
            self.addChild(tileNode)
            
            tileCount += 1
            
          let pointTopLeft = CGPoint (x:0,y:0)
            let pointTopRight = CGPoint (x:size.width,y:0)
            self.physicsBody = SKPhysicsBody(edgeFrom: pointTopLeft, to: pointTopRight)
            self.physicsBody?.categoryBitMask = 2
            self.physicsBody?.collisionBitMask = 1
            self.physicsBody?.contactTestBitMask = 1
         
        }
        
        jumpWidth = tileSize.width * floor(tileCount/3)
    
    }
    func checkForReposition (playerProgress: CGFloat){
        let groundJumpPosition = jumpWidth * jumpCount
        
        if playerProgress >= groundJumpPosition {
            self.position.x += jumpWidth
            jumpCount += 1
        }
    }
    
    
}

