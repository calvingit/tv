//
//  ViewController.swift
//  TV
//
//  Created by 张文 on 2020/3/9.
//  Copyright © 2020 张文. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {

    @IBOutlet var webView: WKWebView!

    var index = 0 {
        didSet {
            let (name, url) =  channels[index]
            title = name
            play(url)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addChannelMenus()
        index = 0
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.

        }
    }

    /// 键盘事件处理
    override func keyDown(with event: NSEvent) {
        super.keyDown(with: event)
        guard let specialKey = event.specialKey else { return }

        // 左、上箭头切换上一个频道
        if (specialKey == .leftArrow || specialKey == .upArrow) {
            if index == 0 {
                index = channels.count - 1
            }
            else {
                index -= 1
            }

        }
        // 右、下箭头切换下一个频道
        else if (specialKey == .rightArrow || specialKey == .downArrow) {
            if index == (channels.count - 1) {
                index = 0
            }
            else {
                index += 1
            }
        }
    }

    /// 播放
    func play(_ url: String) {
        webView.load(URLRequest(url: URL(string: url)!))
    }
}


extension ViewController {

    /// 添加频道菜单
    func addChannelMenus() {
        guard let mainMenu = NSApp.mainMenu else { return }

        let channelMenu = NSMenuItem(title: "频道", action: nil, keyEquivalent: "C")
        let subMenu = NSMenu(title: "频道")
        for i in 0..<channels.count {
            let (name, _) = channels[i]
            let channelItem = NSMenuItem(title: name, action: #selector(clickChannel), keyEquivalent: "")
            channelItem.tag = i
            subMenu.addItem(channelItem)
        }
        channelMenu.submenu = subMenu

        mainMenu.addItem(channelMenu)
        NSApp.mainMenu = mainMenu
    }

    @objc func clickChannel(_ sender: NSMenuItem) {
        index = sender.tag
    }
}

