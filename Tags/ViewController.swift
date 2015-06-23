//
//  ViewController.swift
//  Tags
//
//  Created by Bernardo Santana on 6/23/15.
//  Copyright (c) 2015 bundle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    var tags = [String]()
    
    @IBOutlet weak var countLabel:UILabel!
    var labels = [UILabel]()

    func randomString() -> NSString {
        
        let len = Int(arc4random_uniform(40))
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            var length = UInt32 (letters.length)
            var rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }

    @IBAction func updateTags(sender: UIButton) {
        tags = randomTags()
        labels = sortedLabelsWith(tags)
        countLabel.text = "Number of labels: \(labels.count)"
        arrangeLabels()
    }
    
    @IBAction func previousTags(sender: UIButton) {
        let staticTags = tags
        labels = sortedLabelsWith(staticTags)
        countLabel.text = "Number of labels: \(labels.count)"
        arrangeLabels()
    }
    
    let padding:CGFloat = 8
    @IBAction func resizeLabels(sender: AnyObject) {
        var emptySpace:CGFloat = 0
        let separators = CGFloat(labels.count + 1)
        var estimatedWidth: CGFloat = (containerView.frame.width - (separators)*padding) / CGFloat(labels.count)
        for (i, label) in enumerate(labels) {
            emptySpace += estimatedWidth - label.frame.width
            let labelsLeft = labels.count - i + 1
            if emptySpace < 0 {
                // No empty space left
                label.frame = CGRectMake(0, 0, estimatedWidth , 30)
            } else {
                estimatedWidth += emptySpace/CGFloat(labelsLeft)
            }
        }
        arrangeLabels()
    }
    
    
    func sortedLabelsWith(array:[String]) -> [UILabel] {
        var labels = [UILabel]()
        for eachString in array {
            let label = UILabel()
            label.text = eachString
            label.backgroundColor = .greenColor()
            label.sizeToFit()
            labels.append(label)
        }
        return labels.sorted({ $0.frame.width < $1.frame.width })
        
    }
    
    func arrangeLabels() {
        containerView.subviews.map({ $0.removeFromSuperview() })
        for i in 0..<labels.count {
            let x = (i == 0) ? 10 : labels[i-1].frame.origin.x + labels[i-1].frame.width + 8
            labels[i].frame.origin = CGPointMake(x, 50)
            containerView.addSubview(labels[i])
        }
    }
    
    func randomTags() -> [String] {
        var tags = [String]()
        for i in 0..<arc4random_uniform(4) {
            let newString = String(randomString())
            tags.append(newString)
        }
        return tags
    }
    

}

