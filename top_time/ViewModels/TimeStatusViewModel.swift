//
//  TimeStatusViewModel.swift
//  top_time
//
//  Created by 이경민 on 7/11/24.
//

import Combine
import Foundation

class TimeStatusViewModel: ObservableObject {
    @Published var showTitle: String = TextConstant.DefaultTimeLabel
    @Published var title: String = TextConstant.DefaultTimeLabel
    @Published var secondRemain: Int = .zero
    @Published var remainProgress: Double = .zero
    private var totalSecond: Int = .zero
    private var timer: Timer?
    
    func setTitle(with new: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.title = "💖 " + new
        }
    }
    
    func updateShowTitle(timeValue: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showTitle = self.title + " " + timeValue
        }
    }
    
    func setTimer(with time: Int) {
        secondRemain = time
        totalSecond = time
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.secondRemain > 0 {
                self.secondRemain -= 1
                self.updateProgress()
                self.updateRemainTimeValue()
            } else {
                self.resetTimer()
            }
        }
    }
    
    func resetTimer(isCancel: Bool = false) {
        guard isCancel == true else {
            sendNotification(title: "TOPTIME", message: "\(title) 시간이 종료되었습니다.")
            return
        }
        
        self.title = TextConstant.DefaultTimeLabel
        self.showTitle = TextConstant.DefaultTimeLabel
        self.timer?.invalidate()
        self.timer = nil
        self.remainProgress = .zero
        self.secondRemain = .zero
    }
    
    private func updateProgress() {
        let progress = 1.0 - (Double(secondRemain) / Double(totalSecond))
        print(secondRemain)
        
        DispatchQueue.main.async {
            self.remainProgress = max(progress, 0)
            print(self.remainProgress)
        }
    }
    
    private func updateRemainTimeValue() {
        let hour = secondRemain / 3600
        let minutes = (secondRemain % 3600) / 60
        let seconds = (secondRemain % 3600) % 60
        
        let remainTimeValue = String(
            format: "%02d:%02d:%02d",
            hour,
            minutes,
            seconds
        )
        
        updateShowTitle(timeValue: remainTimeValue)
    }
}

private extension TimeStatusViewModel {
    enum TextConstant {
        static let DefaultTimeLabel = "💖 시간을 선택해보세요."
    }
    
    func sendNotification(title: String, message: String) {
        let notification = NSUserNotification()
        notification.title = title
        notification.informativeText = message
        NSUserNotificationCenter.default.deliver(notification)
    }
}
