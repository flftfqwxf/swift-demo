//
//  ViewController.swift
//  skypp
//
//  Created by leixianhua on 4/28/17.
//  Copyright © 2017 leixianhua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let showLabel = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenInfo.screenW, height: ScreenInfo.screenH / 2))
    let begin = UIButton(frame: CGRect(x: 0, y: ScreenInfo.screenH / 2, width: ScreenInfo.screenW / 2, height: ScreenInfo.screenH / 2))
    let pause = UIButton(frame: CGRect(x: ScreenInfo.screenW / 2, y: ScreenInfo.screenH / 2, width: ScreenInfo.screenW / 2, height: ScreenInfo.screenH / 2))
    var time: Timer?
    var n = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        subview()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func subview() {
        showLabel.text = "this is label"
        showLabel.textAlignment = .center
        showLabel.textColor = .red
        showLabel.backgroundColor = .yellow
        view.addSubview(showLabel)
        begin.backgroundColor = .blue
        begin.setTitleColor(.red, for: .normal)
        pause.backgroundColor = .green
        begin.setTitle("开始", for: .normal)
        begin.setTitle("结束", for: .selected)
        pause.setTitle("暂停", for: .normal)
        pause.setTitle("继续", for: .selected)
        [begin, pause].forEach {
            ($0.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside))
        }
        view.addSubview(begin)
        view.addSubview(pause)

    }

    func buttonTapped(sender: UIButton) {
        switch sender {
        case begin:
            begin.isSelected = !begin.isSelected
            begin.isSelected ? beginSC() : stopSC()
        case pause:
            pause.isSelected = !pause.isSelected
            pause.isSelected ? pauseSC() : continSC()

        default:
            break
        }


    }

    // MARK: - 操作
    // TODO: - 记得做
    // FIXME: - 提醒

    func beginSC() {
        time = Timer.scheduledTimer(timeInterval: 1.0,
                                    target: self, selector: #selector(changeLabel),userInfo: "s", repeats: true)
    }

    func stopSC() {
        showLabel.text = "0"
        time?.invalidate()
        time = nil
    }

    func pauseSC() {
        if !begin.isSelected {
            return
        }
        time?.invalidate()
        time = nil
    }

    func continSC() {
        if !begin.isSelected {
            return
        }
        beginSC()
    }

    func changeLabel(s: Timer) {
        n += 1
        print(s.userInfo!)
        showLabel.text = String(n)
        //s = "\(x)" | toString(x) | x.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

