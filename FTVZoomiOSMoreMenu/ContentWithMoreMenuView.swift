/**
 * The MIT License (MIT)
 *
 * Copyright (c) 2016 France Télévisions
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
 * to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of
 * the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
 * THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

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