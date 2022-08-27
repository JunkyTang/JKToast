//
//  UIView+Ex.swift
//  JKToast
//
//  Created by Junky on 2022/8/27.
//

import Foundation

extension UIView {
    
    static var toastListKey = "toastListKey"
    var toastList: [UIView] {
        set {
            objc_setAssociatedObject(self, &UIView.toastListKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            if newValue.count > 0 {
                isUserInteractionEnabled = false
            }else{
                isUserInteractionEnabled = true
            }
        }
        get {
            if let list = objc_getAssociatedObject(self, &UIView.toastListKey) as? [UIView] {
                return list
            }
            return []
        }
    }
}
