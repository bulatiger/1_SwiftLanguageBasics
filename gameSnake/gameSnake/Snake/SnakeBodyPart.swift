//
//  SnakeBodyPart.swift
//  gameSnake
//
//  Created by Булат Минибаев on 20.05.2021.
//

import UIKit
import SpriteKit

class SnakeBodyPart: SKShapeNode {
    let diametr = 10
    
    init(atPoint point: CGPoint) {
        super.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: diametr, height: diametr)).cgPath
        fillColor = .green
        strokeColor = .green
        lineWidth = 5
        self.position = point
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diametr - 4), center: CGPoint(x: 5, y: 5))
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = CollisionCategory.snake
        //self.physicsBody?.contactTestBitMask = CollisionCategory.edgeBody | CollisionCategory.apple
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
