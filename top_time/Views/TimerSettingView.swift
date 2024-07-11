//
//  TimerSettingView.swift
//  top_time
//
//  Created by 이경민 on 7/11/24.
//

import SwiftUI

// VIEWS
struct TimeSettingView: View {
    @State private var timerDuration: Int = 1800
    @State private var text: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("표시하고 싶은 텍스트를 입력해보세요.", text: $text)
                .textFieldStyle(.roundedBorder)
            
            Picker("타이머 시간", selection: $timerDuration) {
                Text("15 분").tag(900)
                Text("30 분").tag(1800)
                Text("1 시간").tag(3600)
                Text("1시간 30분").tag(5400)
            }
            .pickerStyle(.segmented)
            
            HStack {
                Button(action: startTimer) {
                    Text("시작").frame(maxWidth: .infinity)
                }
                
                Button(role: .destructive, action: stopTimer) {
                    Text("취소").frame(maxWidth: .infinity)
                }
                
            }
        }
        .frame(width: 300, height: 150)
        .padding()
    }
    
    func startTimer() {
        let values = [
            "name": text,
            "duration": timerDuration
        ] as [String : Any]
        NotificationCenter.default.post(name: Notification.Name("StartTimer"), object: values)
    }
    
    func stopTimer() {
        NotificationCenter.default.post(name: Notification.Name("StopTimer"), object: nil)
    }
}

// PREVIEWS
#Preview {
    TimeSettingView()
}
