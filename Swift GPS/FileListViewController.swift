//
//  FileListViewController.swift
//  Swift GPS
//
//  Created by Venj Chu on 14/6/12.
//  Copyright (c) 2014年 Venj Chu. All rights reserved.
//

import UIKit

class FileListViewController: UITableViewController {

    var files: Array<String>! = []

    override init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }
    
    required init(coder aDecoder: NSCoder!)  {
        super.init(coder:aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        files = dataFiles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Helper
    
    func dataFiles() -> Array<String> {
        let fm = NSFileManager()
        let dirEnum = fm.enumeratorAtPath(UserDocumentPath())
        var fileArray = Array<String>()
        while let file = dirEnum.nextObject() as? String {
            if file.pathExtension == "txt" {
                fileArray.append(UserDocumentPath().stringByAppendingPathComponent(file))
            }
        }
        
        return fileArray
    }
    
    @IBAction func refreshFileList(sender: AnyObject!) {
        files = dataFiles()
        tableView.reloadData()
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return files.count
    }

    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cell = tableView!.dequeueReusableCellWithIdentifier("FileNameIdentifier", forIndexPath: indexPath) as UITableViewCell
        // Configure the cell...
        cell.textLabel.text = files[indexPath!.row].lastPathComponent

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let fileName = tableView!.cellForRowAtIndexPath(indexPath!).textLabel.text
            if fileName {
                let filePath = UserDocumentPath().stringByAppendingPathComponent(fileName)
                let fm = NSFileManager()
                var isDir: ObjCBool = false
                // FIXME: Maybe wrong calling this method.
                if fm.fileExistsAtPath(filePath, isDirectory:&isDir) && !(Bool(isDir)) {
                    var error: NSError?
                    fm.removeItemAtPath(filePath, error:&error)
                    if let e = error {
                        let alert = UIAlertView()
                        alert.title = NSLocalizedString("Error", comment: "Error")
                        alert.message = e.localizedDescription
                        alert.delegate = nil
                        alert.addButtonWithTitle(NSLocalizedString("OK", comment:"OK"))
                        alert.show()
                    }
                }
                files = dataFiles()
                //files.removeAtIndex(indexPath!.row) // FIXME: Why not working?
                tableView!.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        var indexPath = tableView!.indexPathForSelectedRow()
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
        if let vc = segue?.destinationViewController as? FileContentViewController {
            vc.path = files[indexPath!.row]
        }
    }
}
