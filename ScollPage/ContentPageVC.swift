//
//  ContentPageVC.swift
//  ScollPage
//
//  Created by Alex Maca on 15/03/16.
//  Copyright © 2016 Alex Maca. All rights reserved.
//

import UIKit

class ContentPageVC: UIViewController {
    
    @IBOutlet var imgView: UIImageView!
   
    var pageIndex : Int = 0
    var imageFile : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgView.image = UIImage(named: self.imageFile)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
