//
//  AppDelegate.swift
//  LookChecker
//
//  Created by Rahul Rathod on 26/01/2023.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    private let menuBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    private let popover = NSPopover()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = self.menuBarItem.button {
            button.image = NSImage(named: NSImage.Name("MenuBarIcon"))
            button.action = #selector(togglePopover(_:))
        }
        let contentVC = ContentViewController()
        self.popover.contentViewController = contentVC
    }
}

extension AppDelegate {
    @objc func togglePopover(_ sender: Any) {
        if self.popover.isShown {
            self.closePopover(sender)
        } else {
            self.showPopover(sender)
        }
    }
    
    func showPopover(_ sender: Any) {
        guard let button = self.menuBarItem.button else { return }
        self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
    }
    
    func closePopover(_ sender: Any) {
        self.popover.performClose(sender)
    }
}
