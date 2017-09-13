//
//  MoreTextView.swift
//  Demo-AppStore-More
//
//  Created by 孙继刚 on 2017/9/12.
//  Copyright © 2017年 madordie. All rights reserved.
//

import UIKit

class MoreTextView: UITextView {

    var maxNumberOfLines = 0 {
        didSet {
            textContainer.maximumNumberOfLines = maxNumberOfLines
            textContainer.lineBreakMode = .byTruncatingTail
        }
    }

    let more = UILabel()
    var moreInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    var haveMore : Bool {
        // - checkout numberOfLines
        guard maxNumberOfLines != 0 else { return false }
        // - checkout number of lines can be fully displayed
        // TODO: This method seems a bit complicated, but has not found a good way....
        textContainer.maximumNumberOfLines = 0
        sizeToFit()
        let maxLinesHeight = frame.height
        textContainer.maximumNumberOfLines = maxNumberOfLines
        sizeToFit()
        guard maxLinesHeight > frame.height else { return false }
        return true
    }

    func tryShowMore() {
        // clear status
        textContainer.exclusionPaths = []
        more.isHidden = true

        // checkout show all
        guard haveMore else { return }

        // need show more button
        more.isHidden = false
        var lastRect = CGRect.zero
        layoutManager.enumerateEnclosingRects(forGlyphRange: NSRange(location: 0, length: textStorage.string.characters.count), withinSelectedGlyphRange: NSRange(location: Int.max, length: 0), in: textContainer, using: { [weak self] (rect, isStop) in
            guard let _self = self else { return }
            var newRect = rect
            newRect.origin.y += _self.textContainerInset.top
            lastRect = newRect
        })
        more.frame.origin = CGPoint(x: min(lastRect.maxX, frame.width - more.frame.width),
                                    y: lastRect.minY)
        // add more insets
        var rect = more.frame
        rect.origin.x += moreInsets.left
        rect.origin.y += moreInsets.top
        rect.size.width += moreInsets.right
        rect.size.height += moreInsets.bottom
        // add exclusionPaths
        textContainer.exclusionPaths = [UIBezierPath.init(rect: rect)]
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        tryShowMore()
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        if more.superview == nil {
            addSubview(more)
        }
        more.sizeToFit()
        return super.sizeThatFits(size)
    }
}
