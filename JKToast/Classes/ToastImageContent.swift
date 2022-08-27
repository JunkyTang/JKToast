//
//  ToastImageContent.swift
//  JKToast
//
//  Created by Junky on 2022/8/27.
//

import Foundation


public class ToastImageContent: UIView {
    
    
    let image: UIImage?
    let size: CGSize
    
    private override init(frame: CGRect) {
        self.image = nil
        self.size = CGSize(width: 60, height: 60)
        super.init(frame: .zero)
        setupUI()
    }
    
    
    public init(image: UIImage?, size: CGSize = CGSize(width: 60, height: 60)) {
        self.image = image
        self.size = size
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
        addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.size.equalTo(size)
            make.center.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview().offset(10)
            make.top.greaterThanOrEqualToSuperview().offset(10)
        }
    }
    
    
    lazy var imgView: UIImageView = {
        let tmp = UIImageView()
        tmp.contentMode = .scaleAspectFit
        tmp.image = image
        return tmp
    }()
    
    deinit {
        print("\(type(of: self)) deinit")
    }
}


extension ToastImageContent: ToastContentType {
    
    public var contentView: UIView {
        return self
    }
}
