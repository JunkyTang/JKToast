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

extension EnableToastType {
    public var jkt: JKToast {
        return JKToast(targetView: targetView)
    }
}

extension UIViewController: EnableToastType {
    public var targetView: UIView {
        return view
    }
}

extension UIView: EnableToastType {
    public var targetView: UIView {
        return self
    }
}

