//
//  SunnyDayScene.swift
//  IntroSpriteKit
//
//  Created by Victor Zhong on 3/6/17.
//  Copyright © 2017 AccessCode. All rights reserved.
//

import UIKit
import SpriteKit

class SunnyDayScene: SKScene {
    
    let backgroundTexture: SKTexture = SKTexture(imageNamed: "bkgd_sunnyday")
    let catStandingTexture: SKTexture = SKTexture(imageNamed: "moving_kitty_1")
    let catStridingTexture: SKTexture = SKTexture(imageNamed: "moving_kitty_2")
    
    
    var backgroundNode: SKSpriteNode?
    var catNode: SKSpriteNode?
    
    
    override init(size: CGSize) {
        super.init(size: size)
        
        print("init")
        self.backgroundColor = .gray
        
        // initializing and setting the background node's texture
        self.backgroundNode = SKSpriteNode(texture: backgroundTexture)
        self.backgroundNode?.anchorPoint = self.anchorPoint
        
        self.catNode = SKSpriteNode(texture: catStandingTexture)
        self.catNode?.anchorPoint = self.backgroundNode!.anchorPoint
        self.catNode!.setScale(0.4)
        
        self.addChild(self.backgroundNode!)
        self.backgroundNode!.addChild(self.catNode!)
    }
    
    override func didMove(to view: SKView) {
        print("didMove")
        
        let walkingAnimation = SKAction.animate(with: [catStandingTexture, catStridingTexture], timePerFrame: 0.5)
        let infiniteAnimation = SKAction.repeatForever(walkingAnimation)
        
        catNode?.run(infiniteAnimation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let validTouch = touches.first else { return }
        
        let moveAction = SKAction.move(to: validTouch.location(in: self), duration: 1.0)
        //        self.catNode?.run(moveAction)
        
        let catTwit = SKAction.playSoundFileNamed("cat_twit.wav", waitForCompletion: false)
        //        self.catNode?.run(catTwit)
        
        let groupAction = SKAction.group([moveAction, catTwit])
        self.catNode?.run(groupAction)
    }
    
}
