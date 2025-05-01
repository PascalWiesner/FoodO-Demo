//
//  Extension.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 20.02.25.
//

import SwiftUI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        var result: [[Element]] = []
        for index in stride(from: 0, to: self.count, by: size) {
            let chunk = Array(self[index..<Swift.min(index + size, self.count)])
            result.append(chunk)
        }
        return result
    }
}

