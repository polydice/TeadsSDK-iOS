//
//  TeadsSASBannerAdapter.swift
//
//  Created by Jérémy Grosjean on 29/06/2021.
//

import UIKit
import SASDisplayKit
import TeadsSDK

@objc(TeadsSASBannerAdapter)
final class TeadsSASBannerAdapter: NSObject, SASMediationBannerAdapter {

    @objc public weak var delegate: SASMediationBannerAdapterDelegate?
    private var currentBanner: TeadsInReadAdView?
    private var placement: TeadsInReadAdPlacement?
    private weak var controller: UIViewController?

    @objc required public init(delegate: SASMediationBannerAdapterDelegate) {
        super.init()
        self.delegate = delegate
    }

    @objc public func requestBanner(withServerParameterString serverParameterString: String, clientParameters: [AnyHashable: Any], viewController: UIViewController) {
        controller = viewController

        guard let serverParameter = ServerParameter.instance(from: serverParameterString) else {
            delegate?.mediationBannerAdapter(self, didFailToLoadWithError: TeadsAdapterErrorCode.serverParameterError, noFill: false)
            return
        }

        guard let pid = serverParameter.placementId else {
            delegate?.mediationBannerAdapter(self, didFailToLoadWithError: TeadsAdapterErrorCode.pidNotFound, noFill: false)
            return
        }

        let adSettings = serverParameter.adSettings
        addExtrasToAdSettings(adSettings)
        let adViewSize = clientParameters["adViewSize"] as? CGSize ?? viewController.view.bounds.size

        currentBanner = TeadsInReadAdView(frame: CGRect(origin: .zero, size: Helper.bannerSize(for: adViewSize.width)))

        placement = Teads.createInReadPlacement(pid: pid, settings: adSettings.adPlacementSettings, delegate: self)
        placement?.requestAd(requestSettings: adSettings.adRequestSettings)
    }

    private func addExtrasToAdSettings(_ adSettings: TeadsAdapterSettings) {
        let sasVersion = Bundle.init(for: SASAdPlacement.self).infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
        adSettings.setIntegation(TeadsAdapterSettings.integrationSAS, version: sasVersion)
    }

}

extension TeadsSASBannerAdapter: TeadsInReadAdPlacementDelegate {

    public func didReceiveAd(ad: TeadsInReadAd, adRatio: TeadsAdRatio) {
        ad.delegate = self
        currentBanner?.bind(ad)
        currentBanner?.updateHeight(with: adRatio)
        if let banner = currentBanner {
            delegate?.mediationBannerAdapter(self, didLoadBanner: banner)
        } else {
            delegate?.mediationBannerAdapter(self, didFailToLoadWithError: TeadsAdapterErrorCode.loadError, noFill: false)
        }
    }

    public func didFailToReceiveAd(reason: AdFailReason) {
        let isNotFilled = reason.code == .errorNotFilled
        delegate?.mediationBannerAdapter(self, didFailToLoadWithError: reason, noFill: isNotFilled)
    }

    public func didUpdateRatio(ad: TeadsInReadAd, adRatio: TeadsAdRatio) {
        currentBanner?.updateHeight(with: adRatio)
    }

    public func adOpportunityTrackerView(trackerView: TeadsAdOpportunityTrackerView) {
        // adOpportunityTrackerView is handled by TeadsSDK
    }

}
extension TeadsSASBannerAdapter: TeadsAdDelegate {
    public func didRecordImpression(ad: TeadsAd) {
        // not handled by SASDisplayKit
    }

    public func didRecordClick(ad: TeadsAd) {
        delegate?.mediationBannerAdapterDidReceiveAdClickedEvent(self)
    }

    public func willPresentModalView(ad: TeadsAd) -> UIViewController? {
        delegate?.mediationBannerAdapterWillPresentModalView(self)
        return controller
    }

    public func didCatchError(ad: TeadsAd, error: Error) {
        delegate?.mediationBannerAdapter(self, didFailToLoadWithError: error, noFill: false)
    }

    public func didClose(ad: TeadsAd) {
        // not handled by SASDisplayKit
    }

    public func didExpandedToFullscreen(ad: TeadsAd) {
        delegate?.mediationBannerAdapterWillPresentModalView(self)
    }

    public func didCollapsedFromFullscreen(ad: TeadsAd) {
        delegate?.mediationBannerAdapterWillDismissModalView(self)
    }
}
