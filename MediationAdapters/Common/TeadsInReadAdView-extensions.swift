//
//  TeadsInReadAdView-extensions.swift
//  TeadsAdMobAdapter
//
//  Created by Thibaud Saint-Etienne on 15/07/2021.
//

import TeadsSDK
import UIKit

fileprivate var adRatioContext: UInt8 = 0

public extension TeadsInReadAdView {
    @objc
    public var adRatio: TeadsAdRatio? {
        get { objc_getAssociatedObject(self, &adRatioContext) as? TeadsAdRatio }
        set { objc_setAssociatedObject(self, &adRatioContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

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
