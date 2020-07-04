//
//  AboutUsViewController.swift
//  UKaren
//
//  Created by sowah on 7/3/20.
//  Copyright © 2020 sowah. All rights reserved.
//

import UIKit
import iCarousel
import StoreKit

class AboutUsViewController: UIViewController, iCarouselDataSource, iCarouselDelegate, SKStoreProductViewControllerDelegate {

    @IBOutlet var myAppView: iCarousel!
    let urls = [
        "1394266181",
        "1448422669",
        "1447317139",
        "1480591124",
        "1512686987",
        "1475125498",
        "1511221919"
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        myAppView.delegate = self
        myAppView.dataSource = self
        myAppView.type = .rotary
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return urls.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .red
        let imageview = UIImageView(frame: view.bounds)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.addSubview(imageview)
        imageview.contentMode = .scaleAspectFit
        imageview.image = UIImage(named: "icon\(index)")

        return view
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        
        openStoreProductWithiTunesItemIdentifier(urls[index])
        
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        return value
    }
    
    func openStoreProductWithiTunesItemIdentifier(_ identifier: String) {
        let storeViewController = SKStoreProductViewController()
        storeViewController.delegate = self

        let parameters = [ SKStoreProductParameterITunesItemIdentifier : identifier]
        storeViewController.loadProduct(withParameters: parameters) { [weak self] (loaded, error) -> Void in
            if loaded {
                // Parent class of self is UIViewContorller
                self?.present(storeViewController, animated: true, completion: nil)
            }
        }
    }
    private func productViewControllerDidFinish(viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func facebookTap(_ sender: Any) {
        if let url = URL(string: "https://www.facebook.com/KarenInfoTech/") {
            UIApplication.shared.open(url)
        }
    }

    @IBAction func visitOurWebsiteTap(_ sender: Any) {
        if let url = URL(string: "https://kareninfotech.com") {
            UIApplication.shared.open(url)
        }
    }
}
