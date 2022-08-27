//
//  ViewController.swift
//  JKToast
//
//  Created by T2015 on 08/27/2022.
//  Copyright (c) 2022 T2015. All rights reserved.
//

import UIKit
import JKToast
import SwiftGifOrigin

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "显示", style: .plain, target: self, action: #selector(showToast))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "隐藏", style: .plain, target: self, action: #selector(hideToast))
        
        view.addSubview(table)
        table.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.snp.topMargin)
        }
        
        
        list = [
            positionList,
            timeList,
            contentList
        ]
    }

    
    
    let positionList = [ToastPosition.topOffset(80), ToastPosition.centerOffset(0), ToastPosition.bottomOffset(-80)]
    let timeList: [TimeInterval] = [0, 2, 4, 6, 8]
    let contentList: [ToastContentType] = [
        ToastMessageContent(message: "文本消息"),
        ToastImageContent(image: UIImage.gif(name: "hud_loading"))
    ]
    
    var list: [[Any]] = [] {
        didSet {
            table.reloadData()
        }
    }
    
    var selectedPosition: ToastPosition = .centerOffset(0)
    var selectedTime: TimeInterval = 0
    var selectedContentIndex: Int = 0
    
    
    
    @objc func showToast() {
        
        let currentContent = contentList[selectedContentIndex]
        
        if let _ = currentContent as? ToastMessageContent {
            jk_Toast.show(content: ToastMessageContent(message: "文本消息"), position: selectedPosition, retainTime: selectedTime)
        }
        if let _ = currentContent as? ToastImageContent {
            jk_Toast.show(content: ToastImageContent(image: UIImage.gif(name: "hud_loading")), position: selectedPosition, retainTime: selectedTime)
        }
    }
    
    @objc func hideToast() {
        jk_Toast.hide()
    }
    
    lazy var table: UITableView = {
        let tmp = UITableView(frame: .zero, style: .plain)
        tmp.delegate = self
        tmp.dataSource = self
        tmp.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return tmp
    }()
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let subList = list[section]
        return subList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        if indexPath.section == 0 {
            let position = positionList[indexPath.row]
            cell.textLabel?.text = position.desc
            cell.accessoryType = position == selectedPosition ? .checkmark : .none
        }
        else if indexPath.section == 1 {
            let time = timeList[indexPath.row]
            cell.textLabel?.text = "\(time)"
            cell.accessoryType = time == selectedTime ? .checkmark : .none
        }
        else {
            let content = contentList[indexPath.row]
            cell.textLabel?.text = "\(type(of: content))"
            cell.accessoryType = selectedContentIndex == indexPath.row ? .checkmark : .none
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titles = ["显示位置", "显示时间", "toast类型"]
        return titles[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 0 {
            selectedPosition = positionList[indexPath.row]
        }
        else if indexPath.section == 1 {
            selectedTime = timeList[indexPath.row]
        }
        else {
            selectedContentIndex = indexPath.row
        }
        table.reloadSections(IndexSet(integer: indexPath.section), with: UITableViewRowAnimation.none)
    }
    
}



extension ToastPosition: Equatable {
    
    var typeString: String {
        switch self {
        case .topOffset(_):
            return "top"
        case .centerOffset(_):
            return "center"
        case .bottomOffset(_):
            return "bottom"
        }
    }
    
    var desc: String {
        switch self {
        case .topOffset(let offset):
            return "上方偏移\(offset)"
        case .centerOffset(let offset):
            return "中间偏移\(offset)"
        case .bottomOffset(let offset):
            return "下方偏移\(offset)"
        }
    }
    
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.typeString == rhs.typeString
    }
    
}


