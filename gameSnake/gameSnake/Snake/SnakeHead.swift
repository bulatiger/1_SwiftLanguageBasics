//
//  SnakeHead.swift
//  gameSnake
//
//  Created by Булат Минибаев on 20.05.2021.
//

import UIKit

class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
        
        self.physicsBody?.categoryBitMask = CollisionCategory.snakeHead
        //self.physicsBody?.contactTestBitMask = CollisionCategory.apple | CollisionCategory.edgeBody
        self.physicsBody?.contactTestBitMask = CollisionCategory.apple | CollisionCategory.edgeBody | CollisionCategory.snake
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
