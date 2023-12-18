//
//  ArcadeGameScene.swift
//  ArcadeGameTemplate
//

import SpriteKit
import SwiftUI
import AVFoundation
var backgroundMusicPlayer: AVAudioPlayer!

func playBackgroundMusic(filename: String) {
    let resourceUrl = Bundle.main.url(forResource: filename, withExtension: nil)
    
    guard let url = resourceUrl else {
        print("could not find file: \(filename)")
        return
    }
    
    do {
        backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.volume = 5.0
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
    } catch {
        print("Error creating AVAudioPlayer: \(error)")
    }
}

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Player: UInt32 = 1
    static let Ground: UInt32 = 2
    static let Elves : UInt32 = 4
    static let Obstacles : UInt32 = 8
    static let DamagedPlayer : UInt32 = 16
    static let Gifts : UInt32 = 32
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
    let initialPlayerPosition = CGPoint(x: 150, y: 250)
    var playerProgress = CGFloat()
    let encounterManager = EncounterManager()
    var nextEncounterSpawnPosition = CGFloat (150)
    let sun = Sun()
    let gift = Gifts()
    let rectangleScore = Rectangle()
    let hud = HUD()
    
    
    @Published var giftsCollected : Int = 0
        
    
    
    var giftList : [SKSpriteNode] = []
    var backgrounds : [Background] = []
    let elf = Elves()
    
    
   
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = .zero
        self.backgroundColor = UIColor(red:0.4, green:0.6, blue:0.95, alpha:1.0)
        self.camera = cam
        player.position = initialPlayerPosition
        self.addChild(player)
        //  player.RunningPlayer()
        ground.position = CGPoint (x: -self.size.width * 2, y: 30)
        ground.size = CGSize (width: self.size.width * 6, height: 0)
        ground.createChildren()
        self.addChild(ground)
        sun.position.y = 250
        sun.zPosition = -11
        self.addChild(sun)
        encounterManager.addEncountersToScene(gameScene: self)
        self.addChild(elf)
        elf.position = CGPoint(x: -2000, y: -2000)
        self.addChild(gift)
        gift.position = CGPoint(x: -2000, y: -2000)
        // Add the camera itself to the scene's node tree: 
        self.addChild(self.camera!)
        // Position the camera node above the game elements: 
        self.camera!.zPosition = 50
        // Create the HUD's child nodes: 
        hud.createHudNodes(screenSize: self.size)
        // Add the HUD to the camera's node tree: 
        self.camera!.addChild(hud)
        
      
        
        
       
        /*  for child in self.children {
         if child.name == "gift" {
         if let child = child as? SKSpriteNode {
         giftList.append(child)
         }
         }
         }
         print (giftList.count)
         */
        
        
        
        
        
        self.setUpGame()
        self.physicsWorld.contactDelegate = self
        //   self.setUpPhysicsWorld()
        playBackgroundMusic(filename: "Backgroundsound.mp3")
     let filename = "Backgroundsound.mp3"
        
        // Instantiate three Backgrounds to the backgrounds array:
                      for _ in 0..<3 {
                          backgrounds.append(Background())
                      }
                      // Spawn the new backgrounds:
                      backgrounds[0].spawn(parentNode: self,
                          imageName: "foreground", zPosition: -5,
                          movementMultiplier: 0.75)
                      backgrounds[1].spawn(parentNode: self,
                          imageName: "midground", zPosition: -10,
                          movementMultiplier: 0.5)
                      backgrounds[2].spawn(parentNode: self,
                          imageName: "background", zPosition: -15,
                          movementMultiplier: 0.2)
        
        
        
    }
    func didBegin(_ contact: SKPhysicsContact){
        
        //PLAYER & GROUND
        if (contact.bodyA.categoryBitMask == 1  && contact.bodyB.categoryBitMask == 2) || (contact.bodyA.categoryBitMask == 16  && contact.bodyB.categoryBitMask == 2) {
            player.playerInAir = false
            player.stopJumping()
            hud.setHealthDisplay(newHealth: player.health)
        //    print ("Contatto")
        }
        if (contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1) || (contact.bodyA.categoryBitMask == 2  && contact.bodyB.categoryBitMask == 16) {
            player.playerInAir = false
            player.stopJumping()
            hud.setHealthDisplay(newHealth: player.health)
        //    print ("Contatto")
        }
        
        // PLAYER & ENEMIES
        if contact.bodyA.categoryBitMask == 1  && contact.bodyB.categoryBitMask == 4 {
        //   print ("take damage")
            player.takeDamage()
            hud.setHealthDisplay(newHealth: player.health)
        }
        if contact.bodyA.categoryBitMask == 4 && contact.bodyB.categoryBitMask == 1  {
       //     print ("take damage")
             player.takeDamage()
            hud.setHealthDisplay(newHealth: player.health)
        }
        
        //PLAYER & GIFTS
        if (contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 32) ||
            (contact.bodyA.categoryBitMask == 16 && contact.bodyB.categoryBitMask == 32){
            gift.collect()
            self.giftsCollected += 10
            hud.setGiftCountDisplay(newGiftCount: self.giftsCollected)
            
            
        }
        if (contact.bodyA.categoryBitMask == 32 && contact.bodyB.categoryBitMask == 1) ||
            (contact.bodyA.categoryBitMask == 32 && contact.bodyB.categoryBitMask == 16){
            gift.collect()
            
            self.giftsCollected += 10
            hud.setGiftCountDisplay(newGiftCount: self.giftsCollected)
          //  print (self.giftsCollected)
        }
        
        
        
        
     
        
        
     /*   let otherBody : SKPhysicsBody
        if (contact.bodyA.categoryBitMask & 1) > 0 {
            otherBody = contact.bodyB
        } */
    }
    
    //Keep camera on player
    
    override func didSimulatePhysics() {
        self.camera!.position.x = player.position.x + 250
        self.camera!.position.y = 170
        
        sun.position.x = player.position.x + 500
        
        playerProgress = player.position.x - initialPlayerPosition.x
        ground.checkForReposition(playerProgress: playerProgress)
        
        if player.position.x > nextEncounterSpawnPosition {
            encounterManager.placeNextEncounter(
                currentXPos: nextEncounterSpawnPosition)
            nextEncounterSpawnPosition += 1200
            
            let elfRoll = 0
            if elfRoll == 0 {
                // Only move the star if it is off the screen.
                if abs(player.position.x - elf.position.x)
                    > 1200 {
                    elf.position = CGPoint(x:
                                            nextEncounterSpawnPosition, y: 30)
                    // Remove any previous velocity and spin:
                    elf.physicsBody?.angularVelocity = 0
                    elf.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                }
            }
            let giftRoll = 0
            if giftRoll == 0 {
                // Only move the star if it is off the screen.
                if abs(player.position.x - gift.position.x)
                    > 200 {
                    // Y Position 50-450:
                    let randomYPos = 50 +
                    CGFloat(arc4random_uniform(200))
                    gift.position = CGPoint(x:
                                            nextEncounterSpawnPosition, y: randomYPos)
                    // Remove any previous velocity and spin:
                    gift.physicsBody?.angularVelocity = 0
                    gift.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                }
            }
        }
        
        for background in self.backgrounds {
            background.updatePosition(playerProgress:
                                        playerProgress)
        }
    }
    
   
    
    override func update(_ currentTime: TimeInterval) {
     //   print (player.playerInAir)
     //   print (player.health)
        player.update()
        
       /* var GiftList : [SKSpriteNode] = []
        enumerateChildNodes(withName: "elf") { [self] node, _ in
            let gift = node as! SKSpriteNode
            GiftList.append(gift)
        }
        print (GiftList.count) */
        
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
        if !player.playerInAir {
            player.isJumping ()
        }
        // TODO: Customize!
     /*   if player.jumpCount < 3 {
            player.isJumping(tapPos: (touches.first!.location(in: self.view)))
        } */
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: Customize!
     /*   for touch in touches {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
        } */
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: Customize!
    
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
        
        return player.health == 0
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
