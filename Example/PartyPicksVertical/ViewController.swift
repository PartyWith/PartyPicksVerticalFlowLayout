//
//  ViewController.swift
//  PartyPicksVertical
//
//  Created by Felipe Ricieri on 18/11/2017.
//  Copyright © 2017 Ricieri ME. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak private var collection: UICollectionView!
    @IBOutlet private var dataSource : ViewControllerDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If you choose to implement your flowLayout through Storyboard (just like I did in this tutorial),
        // then it's important to fill the delegate property up
        if  let flowLayout = collection.collectionViewLayout as? PartyPicksVerticalFlowLayout {
            // #warning: Your app will crash if you don't implement this property
            flowLayout.delegate = dataSource
            // Additional setups
            flowLayout.cellHeight = 40
            flowLayout.cellSpacing = 10
            flowLayout.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
}

// MARK: - Data Source
class ViewControllerDataSource : NSObject, UICollectionViewDataSource {
    
    private var source : [String] = [
        "Amsterdam", "Berlin", "London", "New York", "San Francisco", "Paris", "Sydney", "Los Angeles", "São Paulo", "Rio de Janeiro",
        "Amsterdam", "Berlin", "London", "New York", "San Francisco", "Paris", "Sydney", "Los Angeles", "São Paulo", "Rio de Janeiro",
        "Amsterdam", "Berlin", "London", "New York", "San Francisco", "Paris", "Sydney", "Los Angeles", "São Paulo", "Rio de Janeiro",
        "Amsterdam", "Berlin", "London", "New York", "San Francisco", "Paris", "Sydney", "Los Angeles", "São Paulo", "Rio de Janeiro"
    ]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let object = source[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExampleCollectionCell.cellIdentifier, for: indexPath) as! ExampleCollectionCell
        cell.viewModel = ExampleCollectionCell.ViewModel(title: object)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// MARK: - Party Picks Flow Layout Delegate
extension ViewControllerDataSource : PartyPicksVerticalFlowLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, widthForCellAt indexPath: IndexPath, withHeight height: CGFloat) -> CGFloat {
        let object = source[indexPath.row]
        return cellWidthFor(text: object)
    }
    
    func didPreparedFlowLayout() {
        // Place any code you want to perfom after the layout is complete here
    }
    
    private func cellWidthFor(text: String) -> CGFloat {
        
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.text = text
        label.sizeToFit()
        
        var rect = label.intrinsicContentSize
        rect.width += 30 // Padding
        let newWidth = rect.width.rounded()
        
        return newWidth
    }
}

// MARK: - UI Resources
class ExampleCollectionCell : UICollectionViewCell {
    
    static let cellIdentifier : String = "cell"
    
    @IBOutlet weak private var title : UILabel!
    
    var viewModel : ViewModel? { didSet {
        title.text = viewModel?.title
        }}
}

extension ExampleCollectionCell {
    struct ViewModel {
        var title : String = ""
        init(title: String) {
            self.title = title
        }
    }
}

