//
//  GameLogic.swift
//
//  Created by 김하민 on 7/18/24.
//

import Foundation

enum Direction {
    case north, south, west, east, none
}

struct GameData {
    
    var blocks: [BlockData] = []
    var score: Int = 0
    var direction: Direction
    
    init(blocks: [BlockData], score: Int, direction: Direction) {
        self.blocks = []
        self.score = 0
        self.direction = .none
    }
    
    mutating func swipe(_ direction: Direction) {
        
    }
    
    func nextPosition(of block: BlockData) -> GridPosition? {
        switch direction {
        case .north: return GridPosition(x: block.gridPosition.x, y: block.gridPosition.y - 1)
        case .south: return GridPosition(x: block.gridPosition.x, y: block.gridPosition.y + 1)
        case .west: return GridPosition(x: block.gridPosition.x - 1, y: block.gridPosition.y)
        case .east: return GridPosition(x: block.gridPosition.x + 1, y: block.gridPosition.y)
        case .none: return nil
        }
    }
    
    mutating func moveBlocks() {
        var movedBlocks: [BlockData] = []
        
        for i in 0...3 {
            var targetBlocks: [BlockData] = []
            
            switch direction {
            case .north, .south: targetBlocks = blocks.filter { $0.gridPosition.x == i }
            case .east, .west: targetBlocks = blocks.filter { $0.gridPosition.y == i }
            case .none: break
            }
            
            for j in 0..<targetBlocks.count {
                switch direction {
                case .north: targetBlocks[j].move(to: GridPosition(x: i, y: j))
                case .south: targetBlocks[j].move(to: GridPosition(x: i, y: j))
                case .west: targetBlocks[j].move(to: GridPosition(x: i, y: j))
                case .east: targetBlocks[j].move(to: GridPosition(x: i, y: j))
                case .none: break
                }
            }
            movedBlocks.append(contentsOf: targetBlocks)
        }
        blocks = movedBlocks
    }
}
