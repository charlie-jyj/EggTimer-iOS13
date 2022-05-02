//
//  Timer.swift
//  EggTimer
//
//  Created by 정유진 on 2022/04/20.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation
import UIKit

class EggTimerBuilder {
    /*
     - builder class의 생성자는 public, 필수값을 생성자의 파라미터로 받는다.
     - optional한 값에 대하여 메서드로 제공하며 메서드의 리턴 값이 빌더 객체 자신
        - 이 경우를 고려하면 class로 설계해야
     - 빌더 클래스 내에 build 메서드를 정의하여 클라이언트 프로그램에게 최종 생성 결과물을 제공한다. 따라서 생성 대상은 private
     */
    
    private var selectedHardness: String
    var viewController: ViewController?
    var callback: TimerHandler?
    
    init(hardness: String) {
        selectedHardness = hardness
    }
    
    typealias TimerHandler = (Timer) -> Void
    
    func setTimerFireMethod(handler: @escaping TimerHandler) -> EggTimerBuilder {
        self.callback = handler
        return self
    }
    
    func build() -> EggTimer? {
        if let selectedTimer = TimerType.allCases.filter({$0.rawValue == selectedHardness}).first,
           let time = selectedTimer.time,
           let block = self.callback
        {
            var eggTimer = EggTimer(
                timer: Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: block),
                timerType: selectedTimer,
                totalTime: time*60.0)
            eggTimer.delegate = self
            return eggTimer
        }
        else {
           fatalError("fail to build egg timer")
        }
    }
    
}
