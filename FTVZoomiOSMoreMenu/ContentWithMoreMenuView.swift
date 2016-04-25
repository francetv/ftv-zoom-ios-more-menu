//
//  ContentWithMoreMenuView.swift
//  FTVZoomiOSMoreMenu
//
//  Created by William Archimède on 25/04/2016.
//  Copyright © 2016 William Archimède. All rights reserved.
//

import UIKit

class ContentWithMoreMenuView: UIView {

    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var morePanel: UIView!
    @IBOutlet weak var contentPanel: UIView!

    var isMorePanelOpen = false


    // MARK: - More panel

    @IBAction func onMoreButtonTapped() {

        if isMorePanelOpen {
            closeMorePanel()
        } else {
            openMorePanel()
        }
    }

    private func openMorePanel() {

        isMorePanelOpen = true
        animatePanelOpening()
    }

    private func closeMorePanel() {

        isMorePanelOpen = false
        animatePanelClosing()
    }


    // MARK: - Animate the panel opening / closing

    private func animatePanelOpening() {

        animateCircle(open: true)
        animateButtonRotation(open: true)
    }

    private func animatePanelClosing() {

        animateCircle(open: false)
        animateButtonRotation(open: false)
    }

    private func animateCircle(open open: Bool) {

        // Creates two circular UIBezierPath instances; one is the size of the button and the second has a radius large enough
        // to cover the entire screen. The final animation will be between these two bezier paths.
        let circleMaskPathInitial = UIBezierPath(ovalInRect: moreButton.frame)
        let extremePoint = CGPoint(x: moreButton.center.x, y: moreButton.center.y - CGRectGetHeight(bounds))
        let radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y))
        let circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(moreButton.frame, -radius, -radius))

        // Creates a new CAShapeLayer to represent the circle mask. We assign its path value with the final circular path after
        // the animation to avoid the layer snapping back after the animation completes.
        let maskLayer = CAShapeLayer()

        if open {
            maskLayer.path = circleMaskPathFinal.CGPath
        } else {
            maskLayer.path = circleMaskPathInitial.CGPath
        }
        morePanel.layer.mask = maskLayer

        // Creates a CABasicAnimation on the path key path that goes from circleMaskPathInitial to circleMaskPathFinal.
        // You also register a delegate, as you’ll do some cleanup after the animation completes.
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        if open {
            maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
            maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        } else {
            // Close
            maskLayerAnimation.fromValue = circleMaskPathFinal.CGPath
            maskLayerAnimation.toValue = circleMaskPathInitial.CGPath
            maskLayerAnimation.delegate = self
        }
        maskLayerAnimation.duration = 0.2

        morePanel.hidden = false
        maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
    }

    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        morePanel.hidden = !isMorePanelOpen
    }

    private func animateButtonRotation(open open: Bool) {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = 0.2
        animation.additive = true
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        let rotationAngle = 90.0 * 3.0 / 180.0 * M_PI_2
        if open {
            animation.fromValue = 0.0
            animation.toValue = rotationAngle
        } else {
            animation.fromValue = rotationAngle
            animation.toValue = 0.0
        }
        moreButton.layer.addAnimation(animation, forKey: "rotation")
    }
}