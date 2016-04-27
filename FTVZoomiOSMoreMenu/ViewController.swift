//
//  ViewController.swift
//  FTVZoomiOSMoreMenu
//
//  Created by William Archimède on 25/04/2016.
//  Copyright © 2016 William Archimède. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        addContentView()
    }

    private func addContentView() {

        let contentMoreView = NSBundle.mainBundle().loadNibNamed("ContentWithMoreMenuView", owner: self, options: nil)[0] as! ContentWithMoreMenuView

        let constraints = [
            NSLayoutConstraint(item: contentMoreView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal,
                toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 300),
            NSLayoutConstraint(item: contentMoreView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 161),
            NSLayoutConstraint(item: contentMoreView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentMoreView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)]

        view.addSubview(contentMoreView)
        view.addConstraints(constraints)
        view.setNeedsLayout()
    }
}