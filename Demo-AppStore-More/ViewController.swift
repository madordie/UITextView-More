//
//  ViewController.swift
//  Demo-AppStore-More
//
//  Created by 孙继刚 on 2017/9/12.
//  Copyright © 2017年 madordie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let text = TruncateTextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
        view.addSubview(text)

        text.frame = CGRect(x: 20, y: 40, width: 150, height: 10)
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.gray.cgColor
        text.isEditable = false
        text.isScrollEnabled = false
        text.textContainerInset = UIEdgeInsets(top: 0, left: -text.textContainer.lineFragmentPadding, bottom: 0, right: -text.textContainer.lineFragmentPadding)
        text.font = UIFont.systemFont(ofSize: 12)
        text.isSelectable = false
        text.maxNumberOfLines = 3
        text.truncateItem.font = UIFont.systemFont(ofSize: 12)

        text.text = "这TMD都是啥都是啥都是啥都是啥都是啥都是啥都是啥都是啥都是啥都是啥都是啥都是啥都是啥都是啥。。。"
        text.truncateItem.text = "查看更多"
        text.truncateItem.textColor = UIColor.blue
        text.truncateItem.adjustsFontSizeToFitWidth = true
        text.truncateItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMore)))
        text.truncateItem.isUserInteractionEnabled = true
        text.sizeToFit()
    }
    @objc func showMore() {
        if text.maxNumberOfLines != 0 {
            text.maxNumberOfLines = 0
            text.layoutSubviews()
            text.sizeToFit()
            print(text)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
