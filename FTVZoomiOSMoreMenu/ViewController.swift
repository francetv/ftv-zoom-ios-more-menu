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