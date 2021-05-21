//
//  GameScene.swift
//  gameSnake
//
//  Created by Булат Минибаев on 19.05.2021.
//

import SpriteKit
import GameplayKit


struct CollisionCategory {
    static let snake: UInt32 = 0x1 << 0
    static let snakeHead: UInt32 = 0x1 << 1
    static let apple: UInt32 = 0x1 << 2
    static let edgeBody: UInt32 = 0x1 << 3
}

class GameScene: SKScene {
    
    var snake: Snake?
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.quaternaryLabel
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        view.showsPhysics = true
        
        let counterClockWiseButton = SKShapeNode()
        counterClockWiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockWiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        counterClockWiseButton.fillColor = UIColor.link
        counterClockWiseButton.strokeColor = UIColor.black
        counterClockWiseButton.lineWidth = 3
        counterClockWiseButton.name = "counterClockWiseButton"
        self.addChild(counterClockWiseButton)
        
        let clockWiseButton = SKShapeNode()
        clockWiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockWiseButton.position = CGPoint(x: view.scene!.frame.maxX - 70, y: view.scene!.frame.minY + 30)
        clockWiseButton.fillColor = UIColor.link
        clockWiseButton.strokeColor = UIColor.black
        clockWiseButton.lineWidth = 3
        clockWiseButton.name = "clockWiseButton"
        self.addChild(clockWiseButton)
        
        createApple()
        
        snake = Snake(apPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody?.categoryBitMask = CollisionCategory.edgeBody
        self.physicsBody?.collisionBitMask = CollisionCategory.snake | CollisionCategory.snakeHead
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        for touch in touches {
            
            let touchLocation = touch.location(in: self)
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, touchNode.name == "counterClockWiseButton" || touchNode.name == "clockWiseButton" else {
                return
            }
            
            touchNode.fillColor = .white
            
            if touchNode.name == "counterClockWiseButton" {
                snake!.moveCounterClockWIse()
            } else if touchNode.name == "clockWiseButton" {
                snake!.moveClockWise()
            }
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let touchLocation = touch.location(in: self)
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, touchNode.name == "counterClockWiseButton" || touchNode.name == "clockWiseButton" else {
                return
            }
            
            touchNode.fillColor = .link
            
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        snake!.move()
        
    }
    var deleteApple: Apple?
    func createApple() {
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 10)))
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 90)))
        
        let apple = Apple(position: CGPoint(x: randX, y: randY + 80))
        deleteApple = apple
        self.addChild(apple)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodyes - CollisionCategory.snakeHead
        
        switch collisionObject {
        case CollisionCategory.apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
            break
        case CollisionCategory.edgeBody:
            snake?.removeFromParent()
            deleteApple?.removeFromParent()
            createApple()
            snake = Snake(apPoint: CGPoint(x: view!.scene!.frame.midX, y: view!.scene!.frame.midY))
            self.addChild(snake!)
        case CollisionCategory.snake:   //не пойму почему всегда выполняется после столкновения с яблоком (в том числе просто при нажатии кнопок)
            print("error")
        default:
            break
        }
    }
    
}
