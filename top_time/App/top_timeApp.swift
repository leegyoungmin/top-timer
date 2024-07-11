//
//  top_timeApp.swift
//  top_time
//
//  Created by 이경민 on 7/10/24.
//

import Cocoa
import Combine
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popover = NSPopover()
    var timerStatusViewModel = TimeStatusViewModel()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            let rootView = TimerStatusView(viewModel: self.timerStatusViewModel)
            let view = NSHostingView(rootView: rootView)
            view.translatesAutoresizingMaskIntoConstraints = false
            
            button.addSubview(view)
            button.target = self
            button.isEnabled = true
            button.action = #selector(togglePopover)
            
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: button.topAnchor),
                view.leadingAnchor.constraint(equalTo: button.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: button.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: button.bottomAnchor)
            ])
        }
        
        popover.contentSize = NSSize(width: 500, height: 200)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: TimeSettingView())
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(startTimer),
            name: Notification.Name("StartTimer"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(stopTimer),
            name: Notification.Name("StopTimer"),
            object: nil
        )
    }
    
    @objc private func togglePopover(_ sender: Any?) {
        if let button = statusItem?.button {
            if popover.isShown {
                popover.performClose(nil)
            } else {
                popover.show(
                    relativeTo: button.bounds,
                    of: button,
                    preferredEdge: .minY
                )
            }
        }
    }
    
    @objc private func startTimer(_ notification: Notification) {
        if let values = notification.object as? [String: Any] {
            if let title = values["name"] as? String {
                timerStatusViewModel.setTitle(with: title)
            }
            
            
            if let duration = values["duration"] as? Int {
                timerStatusViewModel.setTimer(with: duration)
            }
        }
    }
    
    @objc private func stopTimer() {
        timerStatusViewModel.resetTimer()
    }
}

@main
struct top_timeApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        Settings { }
    }
}
