//
//  FileContentViewController.swift
//  Swift GPS
//
//  Created by 朱 文杰 on 14-6-12.
//  Copyright (c) 2014年 Venj Chu. All rights reserved.
//

import UIKit

class FileContentViewController: UIViewController {
    
    var path: String!
    var timer: NSTimer {
    return NSTimer.scheduledTimerWithTimeInterval(15, target:self, selector:"reloadFile", userInfo:nil, repeats:false)
    }
    @IBOutlet var textView: UITextView!
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    init(coder aDecoder: NSCoder!)  {
        super.init(coder:aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = path.lastPathComponent
        reloadFile(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readFileContent() -> String {
        return NSString.stringWithContentsOfFile(path, encoding:NSUTF8StringEncoding, error:nil)
    }
    
    @IBAction func reloadFile(sender: AnyObject!) {
        textView.text = readFileContent()
    }

}
