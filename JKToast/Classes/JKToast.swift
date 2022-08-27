//
//  JKToast.swift
//  JKToast
//
//  Created by Junky on 2022/8/27.
//

import Foundation


public struct JKToast<Base:EnableToastType> {
    
    let base: Base
}

extension JKToast {
    
    
    public func show(content: ToastContentType, position: ToastPosition = .centerOffset(0), retainTime: TimeInterval = 0) {
        base.toastShow(content: content, position: position, retainTime: retainTime)
    }
    
    
    public func hide() {
        base.toastHide()
    }
    
    
    public func hideAll() {
        base.toastHideAll()
    }
}



extension EnableToastType {
    public var jk_Toast: JKToast<Self> {
        return JKToast(base: self)
    }
}
