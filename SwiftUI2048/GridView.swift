//
//  GridView.swift
//
//  Created by 김하민 on 7/3/24.
//

import Foundation
import SwiftUI

struct GridView: View {
//    @State var blocks: [BlockData] = []
    @State var cells: [CellPosition] = []
    @State var data: GameData = GameData(blocks: [], score: 0, direction: .north)
    
    let gridSize = 4
    let blockSize: CGFloat = 70
    let spacing: CGFloat = 10
    
    var body: some View {
        ZStack {
            // Background Rectangle
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gridBackground)
                .frame(width: blockSize * 5, height: blockSize * 5)
            
            // Four-by-four board
            VStack(spacing: spacing) {
                ForEach(0..<gridSize, id: \.self) { y in
                    HStack(spacing: spacing) {
                        ForEach(0..<gridSize, id: \.self) { x in
                            CellView(GridPosition(x: x, y: y))
                                .frame(width: blockSize, height: blockSize)
                                .background(
                                    GeometryReader { proxy in
                                        Color.clear
                                            .onAppear {
                                                let cellPosition = CellPosition(on: GridPosition(x: x, y: y),
                                                                                by: proxy.frame(in: .global).center)
                                                if !cells.contains(where: { $0.gridPosition == cellPosition.gridPosition }) {
                                                    cells.append(cellPosition)
                                                }
                                            }
                                    }
                                )
                        }
                    }
                }
            }

            // Makes blocks appear in GridView
            ForEach(data.blocks) { block in
                BlockView(size: blockSize, block: block)
                    .position( getCGPoint(for: block.gridPosition, in: cells) )
            }
        }
        
        HStack {
            Button("Add block") {
                withAnimation(.bouncy) {
                    addNewBlock(number: 2, on: GridPosition(x: 0, y: 2))
//                    addNewBlock(number: 4, on: GridPosition(x: 0, y: 3))
                    addNewBlock(number: 4, on: GridPosition(x: 1, y: 2))
//                    addNewBlock(number: 4, on: GridPosition(x: 1, y: 3))
                    addNewBlock(number: 2, on: GridPosition(x: 2, y: 2))
//                    addNewBlock(number: 4, on: GridPosition(x: 2, y: 3))
                }
            }
                .buttonStyle(.bordered)
            
            Button("Move Blocks") {
                withAnimation(.easeInOut) {
                    data.moveBlocks()
                }
            }
            .buttonStyle(.bordered)
        }
    }
    
    func addNewBlock(number value: Int, on gridPosition: GridPosition) {
        data.blocks.append(BlockData(id: UUID(), value: value, gridPosition: gridPosition))
    }
    
    
    
    
//    func newGame() {
//        blocks = []
//        
//        for _ in 1...1 {
//            addNewTile()
//        }
//    }
    
//    func addNewTile() {
//        let emptyPositions = getAllPositions().filter { position in
//            !blocks.contains { $0.gridPosition == position }
//        }
//        
//        if let randomPosition = emptyPositions.randomElement() {
//            blocks.append(BlockData(id: UUID(), value: 2, gridPosition: randomPosition))
//        }
//    }
    
    func getCGPoint(for gridPosition: GridPosition, in cellPositions: [CellPosition]) -> CGPoint {
        if let cellPosition = cellPositions.first(where: { $0.gridPosition == gridPosition }) {
            return cellPosition.coordinate
        }
        return CGPoint.zero
    }
    
    func getAllPositions() -> [GridPosition] {
        var positions: [GridPosition] = []
        for x in 0..<gridSize {
            for y in 0..<gridSize {
                positions.append(GridPosition(x: x, y: y))
            }
        }
        return positions
    }
    
}
    
extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: minY - 24)
    }
}
    
#Preview {
    GridView()
}
        
        //    func move(in translation: CGSize) {
        //        let direction: Direction
        //        if abs(translation.width) > abs(translation.height) {
        //            direction = translation.width > 0 ? .right : .left
        //        } else {
        //            direction = translation.height > 0 ? .down : .up
        //        }
        //
        //        moveBlocks(in: direction)
        //        mergeBlocks(in: direction)
        //        moveBlocks(in: direction)
        //
        //        if blocks != blocks.sorted(by: { $0.id.uuidString < $1.id.uuidString }) {
        //            addNewTile()
        //        }
        //    }
        
        //    func moveBlocks(in direction: Direction) {
        //        let sortedBlocks = blocks.sorted { block1, block2 in
        //            switch direction {
        //            case .up: return block1.gridPosition.y < block2.gridPosition.y
        //            case .down: return block1.gridPosition.y > block2.gridPosition.y
        //            case .left: return block1.gridPosition.x < block2.gridPosition.x
        //            case .right: return block1.gridPosition.x > block2.gridPosition.x
        //            }
        //        }
        //
        //        for block in sortedBlocks {
        //            var newPosition = block.gridPosition
        //            while canMove(block: block, to: newPosition.moved(in: direction)) {
        //                newPosition = newPosition.moved(in: direction)
        //            }
        //
        //            if let index = blocks.firstIndex(where: { $0.id == block.id }) {
        //                blocks[index].gridPosition = newPosition
        //            }
        //        }
        //    }
        
        //    func mergeBlocks(in direction: Direction) {
        //        let sortedBlocks = blocks.sorted { block1, block2 in
        //            switch direction {
        //            case .up: return block1.gridPosition.y < block2.gridPosition.y
        //            case .down: return block1.gridPosition.y > block2.gridPosition.y
        //            case .left: return block1.gridPosition.x < block2.gridPosition.x
        //            case .right: return block1.gridPosition.x > block2.gridPosition.x
        //            }
        //        }
        //
        //        for i in 0..<sortedBlocks.count {
        //            let block = sortedBlocks[i]
        //            if let mergeblock = sortedBlocks.dropFirst(i + 1).first(where: { $0.gridPosition == block.gridPosition && $0.value == block.value }) {
        //                if let index = blocks.firstIndex(where: { $0.id == block.id }) {
        //                    blocks[index].value *= 2
        //                }
        //                blocks.removeAll(where: { $0.id == mergeblock.id })
        //            }
        //        }
        //    }
        
        //    func canMove(block: BlockData, to newPosition: CGPoint) -> Bool {
        //        guard newPosition.x >= 0 && newPosition.y >= 0
        //            && newPosition.x < CGFloat(gridSize)
        //            && newPosition.y < CGFloat(gridSize)
        //        else { return false }
        //
        //        return !blocks.contains(where: { $0.id != block.id && $0.gridPosition == newPosition })
        //    }


//enum Direction {
//    case up, down, left, right
//}
//
//extension CGPoint {
//    func moved(in direction: Direction) -> CGPoint {
//        switch direction {
//        case .up: return CGPoint(x: x, y: y - 1)
//        case .down: return CGPoint(x: x, y: y + 1)
//        case .left: return CGPoint(x: x - 1, y: y)
//        case .right: return CGPoint(x: x + 1, y: y)
//        }
//    }
//}
//
