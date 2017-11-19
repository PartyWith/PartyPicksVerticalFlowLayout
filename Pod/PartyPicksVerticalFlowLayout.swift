//
//  PartyPicksHorizontalFlowLayout.swift
//  PartyPicksHorizontalFlowLayout
//
//  Created by Felipe Ricieri on 18/11/2017.
//  Copyright © 2017 PartyWith. All rights reserved.
//

import UIKit

/**
 *  Use it to get a left-aligned vertical flow layout behavior
 */
open class PartyPicksVerticalFlowLayout : UICollectionViewFlowLayout {
    
    /**
     * Delegate is required. Here you will define the dynamic width for cells
     */
    open var delegate : PartyPicksVerticalFlowLayoutDelegate!
    
    /**
     * Space between cells (default is 5px)
     */
    open var cellSpacing : CGFloat = 5
    
    /**
     * Cells height (default is 45px)
     */
    open var cellHeight : CGFloat = 45
    
    /**
     * Collection View content inset
     */
    open var contentInset : UIEdgeInsets = .zero
    
    /**
     * The content width will be defined automatically by PartyPicksVerticalFlowLayout class
     */
    public var contentWidth : CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    /**
     * The content height will be defined automatically by PartyPicksVerticalFlowLayout class
     */
    fileprivate(set) public var contentHeight : CGFloat = 0
    
    /**
     * Collection View Content Size
     */
    override open var collectionViewContentSize : CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    /**
     * Attributes cache list
     */
    private var cache : [UICollectionViewLayoutAttributes] = []
    
    
    // MARK: - 🤘🦄  Initialization
    
    
    /**
     * Instantiates PartyPicksVerticalFlowLayout with its delegate.
     */
    public init(delegate: PartyPicksVerticalFlowLayoutDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("🤘🦄 Warning: 🚨 You instantiated PartyPicksVerticalFlowLayout via Interface Builder. Don't forget to declare the delegate.")
    }
    
    /**
     * Prepares the layout. Obs.: PartyPicksVerticalFlowLayout was designed to not accept any supplementary view.
     */
    override open func prepare() {
        
        // Cannot prepare layout without the delegate
        assert(delegate != nil, "🤘🦄 Warning: 🚨 Delegate is nil. Please provide a delegate.")
        
        // Starts at line 0
        var line : CGFloat = 0
        
        // For each item in collectionView...
        for index in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(row: index, section: 0)
            
            // ... we draw the frame
            var frame = CGRect.zero
            frame.size.width = delegate.collectionView(collectionView!, widthForCellAt: indexPath, withHeight: cellHeight)
            frame.size.height = cellHeight
            frame.origin.x = contentInset.left
            frame.origin.y = contentInset.top
            
            if  index > 0 {
                
                // Defines the correct X position
                let previous = cache[index-1]
                frame.origin.x = previous.frame.origin.x + previous.frame.size.width + cellSpacing
                
                // If we reach the right edge already...
                let lineWidth = frame.origin.x + frame.size.width
                if  lineWidth > collectionView!.bounds.width {
                    // Defines the correct X position (another line)
                    line += 1
                    frame.origin.x = contentInset.left
                }
                
                // Defines the correct Y position
                frame.origin.y = line * (cellHeight + cellSpacing)
                frame.origin.y += contentInset.top
            }
            
            // Sets the attribute
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = frame
            
            // Append to attributes cache list
            cache.append(attribute)
        }
        
        // Update content height
        contentHeight = line * (cellHeight + cellSpacing)
        contentHeight += contentInset.top
        contentHeight += contentInset.bottom
        
        // Fire delegate
        delegate?.didPreparedFlowLayout()
    }
    
    // MARK: - 🤘🦄 Layout
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if  attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
    
    // MARK: - 🤘🦄 Reseting
    
    /**
     * Clears the attributes cache list, content height property & invalidates layout.
     */
    func clearCache() {
        invalidateLayout()
        contentHeight = 0
        cache = []
    }
}


// MARK: - 🤘🦄 Delegation


/**
 *  PartyPicksVerticalFlowLayout's Delegate
 */
public protocol PartyPicksVerticalFlowLayoutDelegate {
    
    /**
     * Tells the flow layout which should be the width for a given cell.
     */
    func collectionView(_ collectionView: UICollectionView, widthForCellAt indexPath: IndexPath, withHeight height: CGFloat) -> CGFloat
    
    /**
     * Tells the delegate when flow layout is all set.
     */
    func didPreparedFlowLayout()
}



