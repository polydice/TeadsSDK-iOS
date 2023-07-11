//
//  TeadsInReadAdView-extensions.swift
//  TeadsAdMobAdapter
//
//  Created by Thibaud Saint-Etienne on 15/07/2021.
//

import TeadsSDK
import UIKit

public extension TeadsInReadAdView {
    public func updateHeight() {
        guard
          window != nil,
          let adRatio,
          let width = superview?.frame.width.positive ?? frame.width.positive
        else { return }
        frame = CGRect(origin: .zero, size: sizeThatFits(width: width))
        layoutIfNeeded()
    }

    public func sizeThatFits(width: CGFloat) -> CGSize {
        guard let adRatio else { return .zero }
        var size = CGSize(width: width, height: ceil(adRatio.calculateHeight(for: width)))
        if size.height > 440 {
            size = CGSize(width: size.width * (440 / size.height), height: 440)
        }
        return size
    }
}
