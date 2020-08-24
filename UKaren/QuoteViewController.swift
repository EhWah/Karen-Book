//
//  QuoteCollectionViewController.swift
//  UKaren
//
//  Created by sowah on 7/2/20.
//  Copyright © 2020 sowah. All rights reserved.
//

import UIKit
import iCarousel

class QuoteViewController: UIViewController, iCarouselDataSource {

    @IBOutlet weak var myCarousel: iCarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCarousel.dataSource = self
        myCarousel.autoscroll = 0.5
        myCarousel.type = .coverFlow2
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 20
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 1.5, height: self.view.frame.size.height / 1.5))
        let imageview = UIImageView(frame: view.bounds)
        view.addSubview(imageview)
        imageview.contentMode = .scaleAspectFit
        imageview.image = UIImage(named: "qwe\(index)")

        return view
    }
}
