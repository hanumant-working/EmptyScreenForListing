//
//  EmptyView.swift
//  Dinible
//
//  Created by Hanumant S on 13/01/19.
//  Copyright © 2019 HP Programer. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnEmpty: UIButton!
    
    weak var emptyViewDelegate: EmptyViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    convenience init(image: UIImage? = nil, message: String, buttonTitle: String? = nil) {
        self.init()
    
        lblMessage.text = message
        
        // Hide button when button is nil
        if buttonTitle != nil {
            btnEmpty.setTitle(buttonTitle, for: .normal)
            btnEmpty.addTarget(self, action: #selector(btnEmptyTapped), for: .touchUpInside)
        } else {
            btnEmpty.isHidden = true
        }
        
        if image != nil {
            imgView.image = image
        } else {
            imgView.image = nil
            imgView.isHidden = true
        }
        
    }
    
    private func setup() {
        loadContentView()
    }
    
    @discardableResult
    func loadContentView() -> UIView {
        let nibName = type(of: self).description().components(separatedBy: ".").last ?? ""
        let contentView = (Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView) ?? UIView()
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": contentView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: bindings))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: bindings))
        return contentView
    }
    
    @objc func btnEmptyTapped() {
        emptyViewDelegate?.emptyViewButtonTapped()
    }


}

protocol EmptyViewDelegate: AnyObject {
    func emptyViewButtonTapped()
}


extension UITableView {
    func setEmptyMessage(message:String, emptyImage: UIImage, buttonTitle: String? = nil) {
        let emptyView = EmptyView(image: emptyImage, message: message, buttonTitle: buttonTitle)
        emptyView.frame = self.bounds
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
}
