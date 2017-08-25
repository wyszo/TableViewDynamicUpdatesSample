
# Dynamic TableView Updates Sample (in memory dataSource)

## Problem

You have a tableView that is *NOT* backed by data persistance layer (`CoreData`, `Realm.io`). 

You are getting dynamic content updates on this tableView and want to see cells update, move, get removed and added accordingly - with animation, but without 'flickering' caused by refreshing all cells (even the ones that didn't change). 

## Solution

`TLIndexPathTools` library allows you to do that, but it's surprisingly tricky to setup with Swift and when model updates include insertions/deletion (event though the correct implementation is really simple). This sample is aimed to remove that confusion and show how easy it is to make it work.

The trick is to wrap `TLIndexPathataModel` items in `TLIndexPathItem` (otherwise the library incorrectly compares items by reference - which triggers reloading all cells on every change - which is no different from calling `reloadData`).

So for example if `items` contain model instances array and your model class has `text` property that returns unique identifier, tableView update code might look like this:  

```
let indexPathItems = items.map { TLIndexPathItem(identifier: $0.text, sectionName: nil, cellIdentifier: nil, data: $0) }
indexPathController.dataModel = TLIndexPathDataModel(items: indexPathItems)
```

## Caveates 

When using `TLIndexPathTools` to drive a tableView just remember to set cell reuse identifier to *Cell*. 

## Effect

![](DynamicTableViewUpdates.gif)
