//
//  ToastMessageContent.swift
//  JKToast
//
//  Created by Junky on 2022/8/27.
//

import UIKit
import SnapKit


public class ToastMessageContent: UIView {
    
    let message: String
    
    private override init(frame: CGRect) {
        self.message = ""
        super.init(frame: frame)
        setupUI()
    }
    
    public init(message: String?) {
        self.message = message ?? ""
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        layer.cornerRadius = 8
        clipsToBounds = true
        
        addSubview(msgLab)
        msgLab.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.equalTo(15)
            make.left.equalTo(15)
        }
    }
    
    lazy var msgLab: UILabel = {
        let tmp = UILabel()
        tmp.numberOfLines = 0
        tmp.textAlignment = .center
        tmp.textColor = UIColor.black
        tmp.font = UIFont.systemFont(ofSize: 12)
        tmp.text = message
        return tmp
    }()
    
    
    deinit {
        print("\(type(of: self)) deinit")
    }
}

extension ToastMessageContent: ToastContentType {
    
    public var contentView: UIView {
        return self
    }
}


