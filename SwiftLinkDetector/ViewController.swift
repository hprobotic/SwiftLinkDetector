//
//  ViewController.swift
//  SwiftLinkDetector
//
//  Created by JohnP on 7/22/17.
//  Copyright © 2017 JohnP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultTextLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var textInput: UITextField!
    private var isDeteced = false
    fileprivate var linksProperties: [NSTextCheckingResult]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionButtonPressed(_ sender: Any) {
        guard let textInputContent = textInput.text else { return }
        let att = NSMutableAttributedString.init(string: textInputContent,
                                                 attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14)])
        let result = textInputContent.getAllClickableLinks()
        if let links = result {
            linksProperties = links
            for link in links {
                let content = textInputContent as NSString
                let value = content.substring(with: link.range)
                guard let url = URL.init(string: value) else { return }
                var sourceUrl = URL(string: "mailto://\(url)")
                if !value.characters.contains("@") {
                    sourceUrl = url.absoluteString.hasPrefix("http://") || url.absoluteString.hasPrefix("https://") ? url : URL(string: "http://\(url)")
                }
                att.addAttribute(NSLinkAttributeName, value: sourceUrl ?? "", range: link.range)
                att.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: link.range)
            }
        }
        resultTextLabel?.attributedText = att
    }

}

