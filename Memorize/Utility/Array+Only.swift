//
//  Array+Only.swift
//  Memorize
//
//  Created by Daniel Martinez Condinanza on 5/27/20.
//  Copyright © 2020 danielmartinezcg. All rights reserved.
//

import Foundation

extension Array {
    
    var only: Element? {
        count == 1 ? first : nil
    }
    
}
