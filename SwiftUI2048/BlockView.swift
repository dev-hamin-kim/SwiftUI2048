//
//  BlockView.swift
//
//  Created by 김하민 on 7/1/24.
//

import Foundation
import SwiftUI

struct GridPosition: Equatable {
    let (x, y): (Int, Int)
    
    func isEmpty(in array: [BlockData]) -> Bool {
        if array.contains(where: { $0.gridPosition == self }) {
            return false
        } else {
            return true
        }
    }
}

struct BlockData: Identifiable {
    
    let id: UUID
    var value: Int
    var gridPosition: GridPosition
    
    mutating func move(to newPosition: GridPosition) {
        self.gridPosition = newPosition
    }
    
    func haveSameValue(with block: BlockData?) -> Bool {
        return self.value == block?.value
    }
    
    func haveWall(on direction: Direction) -> Bool {
        switch direction {
        case .north: if self.gridPosition.y == 0 { return true } else { return false }
        case .south: if self.gridPosition.y == 3 { return true } else { return false }
        case .west: if self.gridPosition.x == 0 { return true } else { return false }
        case .east: if self.gridPosition.x == 3 { return true } else { return false }
        case .none: return false
        }
    }
}

struct BlockView: View {

    let size: CGFloat
    let block: BlockData
    
    var colorOfBlock: Color {
        switch block.value {
        case 2: return Color.blockColorFor2
        case 4: return Color.blockColorFor4
        case 8: return Color.blockColorFor8
        case 16: return Color.blockColorFor16
        case 32: return Color.blockColorFor32
        case 64: return Color.blockColorFor64
        case 128: return Color.blockColorFor128
        case 256: return Color.blockColorFor256
        case 512: return Color.blockColorFor512
        case 1024: return Color.blockColorFor1024
        case 2048: return Color.blockColorFor2048
        default: return .black
        }
    }
    
    var colorOfNumber: Color {
        switch block.value {
        case 2, 4: return Color.fontColorBelow8
        case 8, 16, 32, 64, 128, 256, 512, 1024, 2048: return Color.fontColorAbove8
        default: return .black
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(colorOfBlock)
                .frame(width: size, height: size)
            
            Text(String(block.value))
                .font(Font.system(size: 18).bold())
                .foregroundStyle(colorOfNumber)
        }
    }
}

