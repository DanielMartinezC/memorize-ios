//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Daniel Martinez Condinanza on 5/26/20.
//  Copyright © 2020 danielmartinezcg. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        self.firstIndex(where: { $0.id == matching.id })
    }
}
