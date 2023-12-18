//
//  HUD.swift
//  ArcadeGameTemplate
//
//  Created by Micaela Giannetti on 18/12/23.
//

import Foundation
import SpriteKit

class HUD: SKNode {
    var textureAtlas = SKTextureAtlas(named:"HUD")
    var heartNodes: [SKSpriteNode] = []
    // An SKLabelNode to print the coin score:
    let giftCountText = SKLabelNode(text: "000000")
    
    
    func createHudNodes(screenSize: CGSize) {
        let cameraOrigin = CGPoint(
            x: screenSize.width / 2,
            y: screenSize.height / 2)
        // --- Create the coin counter ---
        // First, create and position a bronze coin icon:
        let giftIcon = SKSpriteNode(texture: textureAtlas.textureNamed("gifthud"))
        // Size and position the coin icon:
        let giftPosition = CGPoint(x:
                                    -cameraOrigin.x + 53, y: cameraOrigin.y - 43)
        giftIcon.size = CGSize(width: 26, height: 26)
        giftIcon.position = giftPosition
        // Configure the coin text label:
        giftCountText.fontName = "Inter-Regular"
        let giftTextPosition = CGPoint(x:
                                        -cameraOrigin.x + 71, y: giftPosition.y)
        giftCountText.position = giftTextPosition
        // These two properties allow you to align the
        // text relative to the SKLabelNode's position:
        giftCountText.horizontalAlignmentMode =
        SKLabelHorizontalAlignmentMode.left
        giftCountText.verticalAlignmentMode =
        SKLabelVerticalAlignmentMode.center
        // Add the text label and coin icon to the HUD:
        self.addChild(giftCountText)
        self.addChild(giftIcon)
        // Create three heart nodes for the life meter:
        for index in 0 ..< 3 {
            let newHeartNode = SKSpriteNode(texture:
                                                textureAtlas.textureNamed("heart"))
            newHeartNode.size = CGSize (width: 30,
                                        height: 30)
            // Position the hearts below the coins:
            let xPos = -cameraOrigin.x +
            CGFloat(index * 38) + 63
            let yPos = cameraOrigin.y - 76
            newHeartNode.position = CGPoint(x: xPos,
                                            y: yPos)
            // Keep track of nodes in an array property:
            heartNodes.append(newHeartNode)
            // Add the heart nodes to the HUD:
            self.addChild(newHeartNode)
        } }
    func setGiftCountDisplay(newGiftCount: Int) {
                       // We can use the NSNumberFormatter class to pad
                       // leading 0's onto the coin count:
                       let formatter = NumberFormatter()
                       let number = NSNumber(value: newGiftCount)
                       formatter.minimumIntegerDigits = 6
                       if let giftStr =
                           formatter.string(from: number) {
                           // Update the label node with the new count:
                                    giftCountText.text = giftStr
    } }
    func setHealthDisplay(newHealth: Int) {
                      // Create a fade SKAction to fade lost hearts:
                      let fadeAction = SKAction.fadeAlpha(to: 0.2,
                          duration: 0.3)
                      // Loop through each heart and update its status:
                      for index in 0 ..< heartNodes.count {
                          if index < newHealth {
                              // This heart should be full red:
                              heartNodes[index].alpha = 1
   }
   else {
                              // This heart should be faded:
                              heartNodes[index].run(fadeAction)
                          }

   } }
}
