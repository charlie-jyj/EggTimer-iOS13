//
//  Timer.swift
//  EggTimer
//
//  Created by 정유진 on 2022/04/20.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

protocol EggTimerProtocol {
    var delegate: EggTimerBuilder? { get set }
    var timer: Timer? { get set }
    var timerType: TimerType? { get set }
    var totalTime: Float? { get set }
    func startTimer()
    func endTimer()
}

struct EggTimer: EggTimerProtocol {
    var delegate: EggTimerBuilder?
    var timer: Timer?
    var timerType: TimerType?
    var totalTime: Float?
    
    public func startTimer() {
        if let vc = delegate?.viewController {
            vc.changeTimerStatus()
            timer?.fire()  // timer 시작
        }
    }
    
    public func endTimer() {
        // 새로운 타이머를 설정해서 이전의 타이머를 꺼야할 때,
        if let vc = delegate?.viewController {
            vc.changeTimerStatus()
            timer?.invalidate()
        }
    }
    
}
