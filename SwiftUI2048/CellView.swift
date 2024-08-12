//
//  CellView.swift
//
//  Created by 김하민 on 7/21/24.
//

import Foundation
import SwiftUI

struct CellView: View {

    let gridPosition: GridPosition
    
    init(_ gridPosition: GridPosition) {
        self.gridPosition = gridPosition
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.empty)
            Text("\(gridPosition.x), \(gridPosition.y)")
                .foregroundStyle(Color.gray)
        }
    }
}

struct CellPosition {
    let gridPosition: GridPosition
    let coordinate: CGPoint
    
    init(on gridPosition: GridPosition, by coordinate: CGPoint) {
        self.gridPosition = gridPosition
        self.coordinate = coordinate
    }
}
