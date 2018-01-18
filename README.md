## UITextView-More

使用UITextKit 实现“更多”的折叠效果

[详细文档戳我去blog](https://madordie.github.io/post/appstore-truncate/)

![预览](https://github.com/madordie/UITextView-More/blob/master/Untitled.gif?raw=true)

PS.换行情况下有毒

## 主要代码

### 获取最后一行Rect

```swift
var lastRect = CGRect.zero
layoutManager.enumerateEnclosingRects(forGlyphRange: NSRange(location: 0, length: textStorage.string.characters.count), withinSelectedGlyphRange: NSRange(location: NSNotFound, length: 0), in: textContainer, using: { [weak self] (rect, isStop) in
    guard let _self = self else { return }
    var newRect = rect
    newRect.origin.y += _self.textContainerInset.top
    lastRect = newRect
})
print(lastRect)
```

### 增加 `exclusionPaths`

```swift
textContainer.exclusionPaths = [UIBezierPath.init(rect: rect)]
```

## 备注

- `UITextView`默认携带左右边距，通过`UITextView.textContainer.lineFragmentPadding`获取
- `UITextView`默认携带上下左右边距(`UITextView.textContainerInset`)，其中左右和`lineFragmentPadding`相加
- 此处并没有对[TruncateTextView](https://github.com/madordie/UITextView-More/blob/master/TruncateTextView.swift)进行过多的设置，主要是因为继承在UITextView下，[GIF](https://github.com/madordie/UITextView-More/blob/master/Untitled.gif)中的这部分设置放在了[ViewController.swift](https://github.com/madordie/UITextView-More/blob/master/Demo-AppStore-More/ViewController.swift)中
- 此处使用的是`frame`，可以在`UIView.sizeToFit()`之后获取到`UIView`的`Size`。约束也大抵如此

----

- 感谢[乐逍遥](https://github.com/lexiaoyao20)提供的例子，才找到了`open func truncatedGlyphRange(inLineFragmentForGlyphAt glyphIndex: Int) -> NSRange`方法😂
