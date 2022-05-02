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
    var totalTime: Int? { get set }
    func startTimer()
    func endTimer()
}

struct EggTimer: EggTimerProtocol {
    var delegate: EggTimerBuilder?
    var timer: Timer?
    var timerType: TimerType?
    var totalTime: Int?
    
    public func startTimer() {
        changeTimerStatus() // False -> True
        
        if let initSeconds = totalTime,
           let vc = delegate?.viewController
        {
            vc.setSecondsRemaining(from: initSeconds)  //타이머 시간 초기화
            timer?.fire()  // timer 시작
        }
    }
    
    public func endTimer() {
        // 새로운 타이머를 설정해서 이전의 타이머를 꺼야할 때,
        timer?.invalidate()
        changeTimerStatus() // True -> False
    }
    
    private func changeTimerStatus() {
        guard let vc = delegate?.viewController else { return }
        vc.changeTimerStatus()
    }
    
}
