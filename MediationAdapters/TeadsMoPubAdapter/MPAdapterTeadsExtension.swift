//
//  MPAdapterTeadsExtension.swift
//  TeadsMoPubAdapter
//
//  Created by Jérémy Grosjean on 23/06/2021.
//

import UIKit
import TeadsSDK
import MoPubSDK

@objc extension MPAdView {
    @objc public func register(teadsAdSettings: TeadsAdapterSettings) {
        guard let extra = try? teadsAdSettings.toDictionary() else {
            return
        }
        localExtras = extra
    }
}

@objc extension MPNativeAdRequestTargeting {
    /// This method helps you to add Teads settings to the mopub view
    ///     /// - parameters:
    ///     - teadsAdSettings: teads ad settings
    public func register(teadsAdSettings: TeadsAdapterSettings) {
        guard let extra = try? teadsAdSettings.toDictionary() else {
            return
        }
        localExtras = extra
    }
}

extension TeadsAdapterSettings: MPMediationSettingsProtocol {
    @nonobjc internal class func instance(fromMopubParameters dictionary: [AnyHashable: Any]?) throws -> TeadsAdapterSettings {

        let adSettings = try TeadsAdapterSettings.instance(from: dictionary ?? Dictionary())
        
        adSettings.addExtras(TeadsAdapterSettings.integrationMopub, for: TeadsAdapterSettings.integrationTypeKey)
        adSettings.addExtras(MoPub.sharedInstance().version(), for: TeadsAdapterSettings.integrationVersionKey)
        return adSettings
    }
}