//
//  Timer.swift
//  EggTimer
//
//  Created by 정유진 on 2022/04/20.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

enum Time: String, CaseIterable {
    case Soft
    case Medium
    case Hard
    
    var time: Int {
        switch self {
        case .Soft: return 5
        case .Medium: return 7
        case .Hard: return 12
        }
    }
}

protocol TimerProtocol {
    var time: Int? { get }
    func build() -> Timer
}

struct TimerBuilder: TimerProtocol {
    /*
     - builder class의 생성자는 public, 필수값을 생성자의 파라미터로 받는다.
     - optional한 값에 대하여 메서드로 제공하며 메서드의 리턴 값이 빌더 객체 자신
        - 이 경우를 고려하면 class로 설계해야
     - 빌더 클래스 내에 build 메서드를 정의하여 클라이언트 프로그램에게 최종 생성 결과물을 제공한다. 따라서 생성 대상은 private
     */
    
    
    var time: Int? {
        get { return timer?.storedTime }
    }
    private var selectedHardness: String
    private var timer: Timer?
    
    init(hardness: String) {
        selectedHardness = hardness
        timer = build()
    }
    
    func build() -> Timer {
        let selectedTimer = Time.allCases.filter({$0.rawValue == selectedHardness}).first
        return Timer(timer: selectedTimer, storedTime: selectedTimer?.time)
    }
    
    
}
