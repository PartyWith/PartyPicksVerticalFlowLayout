//
//  FixedHeightCollectionView.swift
//  PartyPicksVertical
//
//  Created by Felipe Ricieri on 19/11/2017.
//  Copyright © 2017 PartyWith. All rights reserved.
//

import UIKit

/**
 *  Bonus: UICollectionView with fixed frame height (content size height is equal to frame height)
 */
open class IntrinsicSizeCollectionView: UICollectionView {
    
    override open var intrinsicContentSize: CGSize {
        get {
            let intrinsic = self.contentSize
            guard intrinsic.width > 0 && intrinsic.height > 0 else {
                return CGSize(width: UIScreen.main.bounds.width, height: 90) // default size
            }
            return intrinsic
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        if !self.bounds.size.equalTo(intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
}
