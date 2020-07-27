# Stacked
iOS UI Component, which can be used for form filling in sequence

## Usage
1. Create an instance of StackedView
```
     stackedView = StackedView(self)
 ```
 where self is passed as Delegate to StackedView, add the instance to the subview and apply the constraints.
 
2. Conform the class implementing the StackedView with the ```StackedViewDelegate```
3. Implement the following delegate functions:

```
 func stackedView(stackedView: StackedView, titleForCTAAt index: Int) -> String
```

```
 func stackedView(stackedView: StackedView, didSelectViewAt index: Int, completion: ((Bool) -> ())?) 
```

```
 func stackedView(stackedView: StackedView, titleAndSubTitleAt index: Int) -> TopViewDetail
```

```
 func stackedView(stackedView: StackedView, viewForItemAt index: Int) -> UIView 
```

```
 func number(ofViewIn stackedView: StackedView) -> Int {
```
