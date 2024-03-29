//
//  APIContentTableViewController.swift
//  dynamicTest
//
//  Created by zixin cheng on 2016-07-14.
//  Copyright © 2016 zixin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class APIContentTableViewController: UITableViewController {
    
    var ajson: JSON!
    var selectedIndex: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ajson = [];
        Alamofire.request(.GET, "http://peeraxservice-devo-beta.elasticbeanstalk.com/rest/v1/tag/categories?userId=243&token=babe2ufqocrpprlmstfnod")
            .validate()
            .responseJSON { response in
                //(request, response, data, error) in
                
                self.ajson = JSON(data: response.data!)
                //[self.tableView .reloadData()]
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
                let courseVersion = self.ajson[0]["title"]
                //print(json.count)
                
                
            
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ajson.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let courseName = self.ajson[indexPath.row]["title"]
        let url = String(self.ajson[indexPath.row]["iconURL"])
        cell.imageView?.image = nil
        Alamofire.request(.GET, url).response { (request, response, data, error) in
            
            
        dispatch_async(dispatch_get_main_queue()) {
             cell.imageView?.image = UIImage(data: data!, scale:1)
        }
       
        }
        cell.textLabel?.text = String(courseName)
        
        //cell.imageView.setImageWithUrl(url)
        //}
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         selectedIndex = indexPath.row
        performSegueWithIdentifier("detailSegue", sender: self)
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let viewControllerB = segue.destinationViewController as! DetailViewController
            viewControllerB.ajson = self.ajson[selectedIndex]
            
        
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
