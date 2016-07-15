//
//  DetailViewController.swift
//  
//
//  Created by zixin cheng on 2016-07-14.
//
//

import UIKit
import SwiftyJSON

class DetailViewController: UIViewController {

    @IBOutlet weak var detail: UILabel!
    
    
    
    var ajson: JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(ajson);
        self.detail.text = String(ajson);
        
        // Do any additional setup after loading the view, typically from a nib.
    }

}
