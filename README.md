# EmptyScreen for UITableView
Set empty screen with image, text and button to UITableView or UICollectionView

1. Just add EmptyView.swift and EmptyView.xib file to your project
2. Set empty screen message from your numberOfRowsInSection UITableViewDataSource Method.

Example: 
```
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sourceData.count == 0 {
            tableView.setEmptyMessage(message: "No List Available", emptyImage: #imageLiteral(resourceName: "ic_empty_list") , buttonTitle: "Add New Item")
            
            // Get button touch event delegate on your controller
            emptyView.emptyViewDelegate = self
        }
        return sourceData.count
   }
   
   extension UIViewController: EmptyViewDelegate {
    func emptyViewButtonTapped() {
        // self.tabBarController?.selectedIndex = 0
    }
   }
 ```
![emptyscreendemo](https://user-images.githubusercontent.com/17447252/51089041-ba4d5000-178c-11e9-8922-689efa0cd42c.png)
