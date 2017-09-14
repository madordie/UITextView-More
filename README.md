## UITextView-More

使用UITextKit 实现“更多”的折叠效果

![预览](https://github.com/madordie/UITextView-More/blob/master/Untitled.gif?raw=true)

## 主要代码

### 获取最后一行Rect

```swift
layoutManager.enumerateEnclosingRects(forGlyphRange: NSRange(location: 0, length: textStorage.string.characters.count), withinSelectedGlyphRange: NSRange(location: Int.max, length: 0), in: textContainer, using: { [weak self] (rect, isStop) in
    guard let _self = self else { return }
    var newRect = rect
    newRect.origin.y += _self.textContainerInset.top
    print(newRect)
})
```

### 增加 `exclusionPaths`

```swift
textContainer.exclusionPaths = [UIBezierPath.init(rect: rect)]
```

## 备注

- `UITextView`默认携带左右边距，通过`UITextView.textContainer.lineFragmentPadding`获取
- `UITextView`默认携带上下左右边距(`UITextView.textContainerInset`)，其中左右和`lineFragmentPadding`相加

----

- 感谢[乐逍遥](https://github.com/lexiaoyao20)提供的例子，才找到了`open func truncatedGlyphRange(inLineFragmentForGlyphAt glyphIndex: Int) -> NSRange`方法😂
