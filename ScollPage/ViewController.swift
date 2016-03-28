//
//  ViewController.swift
//  ScollPage
//
//  Created by Alex Maca on 12/03/16.
//  Copyright © 2016 Alex Maca. All rights reserved.
//

import UIKit
// UIScrollView Method
class ViewController: UIViewController {
    
// MARK: - IBOutlets
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var scrollView: UIScrollView!
    
// MARK: - Private Properties
    
    private let imageArray = ["splash_screen","login_2", "login_3", "login_4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureScrollView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - IBActions

    @IBAction func changePage(sender: AnyObject) {
        // Calculate the frame that should scroll to based on the page control current page.
        var newFrame = scrollView.frame
        newFrame.origin.x = newFrame.size.width * CGFloat(pageControl.currentPage)
        scrollView.scrollRectToVisible(newFrame, animated: true)
    }
    
// MARK: - Private Methods
    
    private func configureScrollView() {
        
        // Enable paging.
        self.scrollView.pagingEnabled = true
        
        // Set the following flag values.
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.scrollsToTop = false
        
        // Set the scrollview content size.
        self.scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * CGFloat(self.imageArray.count), scrollView.frame.size.height)
        
        // Set self as the delegate of the scrollview.
        self.scrollView.delegate = self
        self.pageControl.currentPage = scrollView.currentPage
        
        //add pages to scroll view
        for i in 0..<self.imageArray.count {
            // Load the TestView view.
            let contentView = NSBundle.mainBundle().loadNibNamed("ContentView", owner: self, options: nil)[0] as! UIView
            
            // Set its frame
            contentView.frame = CGRectMake(CGFloat(i) * scrollView.frame.size.width, scrollView.frame.origin.x, scrollView.frame.size.width, scrollView.frame.size.height)
            
            // Get the imageView from xib and set the iamge
            let imageView = contentView.viewWithTag(1) as! UIImageView
            imageView.image = UIImage(named: imageArray[i])
            
            // Add the test view as a subview to the scrollview.
            scrollView.addSubview(contentView)
        }
    }
}

//MARK: - Extensions
//MARK: - UIScrollView Delegate

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.pageControl.currentPage = scrollView.currentPage
    }
}

extension UIScrollView {
    var currentPage: Int {
        return Int((self.contentOffset.x + (0.5 * self.frame.size.width)) / self.frame.width)
    }
}

