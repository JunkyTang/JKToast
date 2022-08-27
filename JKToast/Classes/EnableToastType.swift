//
//  EnableToastType.swift
//  JKToast
//
//  Created by Junky on 2022/8/27.
//

import UIKit
import SnapKit

public protocol EnableToastType {
    var targetView: UIView { get }
}

public extension EnableToastType {
    
    func toastShow(content: ToastContentType, position: ToastPosition = .centerOffset(0), retainTime: TimeInterval = 0) {

        targetView.addSubview(content.contentView)
        targetView.toastList.append(content.contentView)
        switch position {
        case .topOffset(let offset):
            content.contentView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(offset)
                make.height.lessThanOrEqualToSuperview().offset(-20)
                make.width.lessThanOrEqualToSuperview().offset(-20)
            }
        case .centerOffset(let offset):
            content.contentView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(offset)
                make.height.lessThanOrEqualToSuperview().offset(-20)
                make.width.lessThanOrEqualToSuperview().offset(-20)
            }
        case .bottomOffset(let offset):
            content.contentView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(offset)
                make.height.lessThanOrEqualToSuperview().offset(-20)
                make.width.lessThanOrEqualToSuperview().offset(-20)
            }
        }
        
        
        
        if retainTime > 0.0 {
            let contentView = content.contentView
            DispatchQueue.main.asyncAfter(deadline: .now() + retainTime)
            { [weak contentView, weak targetView] in
                guard let targetView = targetView else { return }
                guard let view = contentView else { return }
                view.removeFromSuperview()
                targetView.toastList.removeAll { tmp in
                    return tmp == view
                }
            }
        }
    }
    
    
    func toastHide() {
        if let contentView = targetView.toastList.popLast() {
            contentView.removeFromSuperview()
        }
    }
    
    
    func toastHideAll() {
        targetView.toastList.forEach { toast in
            toast.removeFromSuperview()
        }
        targetView.toastList = []
    }
}



extension UIViewController: EnableToastType {
    public var targetView: UIView {
        return view
    }
}
