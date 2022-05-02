//
//  EggTimerType.swift
//  EggTimer
//
//  Created by 정유진 on 2022/04/21.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

enum TimerType: String, CaseIterable {
    case Soft
    case Medium
    case Hard
    
    var time: Int? {
        let timeTable: [TimerType: Int] = [
            TimerType.Soft: 6,
            TimerType.Medium: 9,
            TimerType.Hard: 12,
        ]
        
        switch self {
        case .Soft: return timeTable[.Soft]
        case .Medium: return timeTable[.Medium]
        case .Hard: return timeTable[.Hard]
        }
    }
}
