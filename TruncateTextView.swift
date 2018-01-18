//
//  TruncateTextView.swift
//  Demo-AppStore-More
//
//  Created by 孙继刚 on 2017/9/12.
//  Copyright © 2017年 madordie. All rights reserved.
//

import UIKit

public class TruncateTextView: UITextView {

    public let truncateItem = UILabel()
    public var truncateItemInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    public var maxNumberOfLines = 0 {
        didSet {
            textContainer.maximumNumberOfLines = maxNumberOfLines
            textContainer.lineBreakMode = .byTruncatingTail
        }
    }
    private lazy var mustLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    private var isCanTruncate: Bool {
        // - checkout numberOfLines
        guard maxNumberOfLines != 0 else { return false }
        // - checkout number of lines can be fully displayed
        let glyphRange = self.layoutManager.glyphRange(for: self.textContainer)
        guard glyphRange.length != 0 else { return false }
        let truncatedRange = self.layoutManager.truncatedGlyphRange(inLineFragmentForGlyphAt: NSMaxRange(glyphRange) - 1)
        if truncatedRange.location == NSNotFound {

            // 遇到部分回车会有问题再次校验
            let label = mustLabel
            label.frame = frame
            label.sizeToFit()
            if abs(label.frame.height - frame.height) < 8 {
                return false
            }
        }

        return true
    }

    private func tryTruncate() {
        // checkout show all
        guard isCanTruncate else { return }
        // need show more button
        truncateItem.isHidden = false
        var lastRect = CGRect.zero
        layoutManager.enumerateEnclosingRects(forGlyphRange: NSRange(location: 0, length: textStorage.string.characters.count), withinSelectedGlyphRange: NSRange(location: NSNotFound, length: 0), in: textContainer, using: { [weak self] (rect, isStop) in
            guard let _self = self else { return }
            var newRect = rect
            newRect.origin.y += _self.textContainerInset.top
            lastRect = newRect
        })
        truncateItem.frame.origin = CGPoint(x: min(lastRect.maxX, frame.width - truncateItem.frame.width),
                                    y: lastRect.minY)
        // add more insets
        var rect = truncateItem.frame
        rect.origin.x += truncateItemInsets.left
        rect.origin.y += truncateItemInsets.top + 1
        rect.size.width += truncateItemInsets.right
        rect.size.height += truncateItemInsets.bottom
        // add exclusionPaths
        textContainer.exclusionPaths = [UIBezierPath.init(rect: rect)]
    }
    override public func layoutSubviews() {
        // clear status
        textContainer.exclusionPaths = []
        truncateItem.isHidden = true
        // layout subviews
        super.layoutSubviews()
        // Waiting for the layout to finish
        DispatchQueue.main.async { [weak self] in
            self?.tryTruncate()
        }
    }
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        if truncateItem.superview == nil {
            addSubview(truncateItem)
        }
        truncateItem.sizeToFit()
        return super.sizeThatFits(size)
    }
}
