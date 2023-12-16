//
//  Sun.swift
//  ArcadeGameTemplate
//
//  Created by Micaela Giannetti on 16/12/23.
//

import Foundation
import SpriteKit

class Sun : SKSpriteNode {
    var textureAtlas : SKTextureAtlas = SKTextureAtlas(named: "Sun")
    var initialSize = CGSize(width: 150, height: 150)
    var eyesAnimation = SKAction()
    
    init(){
        let sunTexture = textureAtlas.textureNamed("Sun1")
        super.init(texture: sunTexture, color:.clear, size: initialSize)
        createAnimations()
        self.run(eyesAnimation)
    }
    
    func createAnimations(){
        let eyesFrames : [SKTexture] = [
            textureAtlas.textureNamed("Sun1"),
            textureAtlas.textureNamed("Sun2"),
            textureAtlas.textureNamed("Sun3"),
            textureAtlas.textureNamed("Sun4"),
            textureAtlas.textureNamed("Sun5"),
            textureAtlas.textureNamed("Sun6"),
            textureAtlas.textureNamed("Sun7"),
            textureAtlas.textureNamed("Sun8"),]
        let eyesAction = SKAction.animate(with: eyesFrames, timePerFrame: 0.4)
        eyesAnimation = SKAction.repeatForever(eyesAction)
        
    }
    required init? (coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
    }
}
