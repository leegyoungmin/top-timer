//
//  TimeStatusView.swift
//  top_time
//
//  Created by 이경민 on 7/11/24.
//

import SwiftUI

struct TimerStatusView: View {
    @StateObject var viewModel: TimeStatusViewModel
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.gray.opacity(0.2))
                    .frame(width: proxy.size.width * viewModel.remainProgress)
            }
            
            HStack {
                Text(viewModel.showTitle)
            }
            .font(.system(size: 12))
            .foregroundStyle(.black)
        }
        .frame(minWidth: 150, idealHeight: 24, alignment: .center)
        .padding(.horizontal, 10)
        .padding(.vertical, 3)
        .transition(.slide)
    }
}
