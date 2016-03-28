//
//  BasePageVC.swift
//  ScollPage
//
//  Created by Alex Maca on 15/03/16.
//  Copyright © 2016 Alex Maca. All rights reserved.
//

import UIKit
//UIPageViewController Method
class BasePageVC: UIViewController {
   
// MARK: - IBOutlets
    
    @IBOutlet var containerView: UIView!
    //@IBOutlet var pageControl: UIPageControl!
    
// MARK: - Private Properties
    
    private var pageViewController: UIPageViewController!
    private var pageImages: [String] = ["splash_screen", "login_2", "login_3", "login_4"]
    private var currentIndex : Int = 0
    private var currentVC : UIViewController!
    //private var pageControl = UIPageControl.appearance()
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initAndCustomizeViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - IBActions
    
    @IBAction func swipeLeftGestureAction(sender: AnyObject) {
        self.turnPageToRight()
    }
    
    @IBAction func swipeRightGestureAction(sender: AnyObject) {
        self.turnPageToLeft()
    }
    
// MARK: - Private Methods
    
    private func initAndCustomizeViews() {
        
        //configure pageControl
        self.pageControl.pageIndicatorTintColor = UIColor.darkGrayColor()
        self.pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        self.pageControl.backgroundColor = UIColor.lightGrayColor()
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        //w
        //self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(0)! as ContentPageVC
        let viewControllers = [startVC]
        
        self.pageViewController!.setViewControllers(viewControllers , direction: .Forward, animated: false, completion: nil)
        self.pageViewController.view.frame = self.containerView.bounds
        
        self.addChildViewController(self.pageViewController)
        self.containerView.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    func turnPageToRight() {
        
        if self.currentIndex < self.pageImages.count - 1 {
            self.currentIndex++
            self.currentVC = self.viewControllerAtIndex(self.currentIndex)
            
            if self.currentVC != nil {
                
                let viewControllers: [UIViewController] = [self.currentVC]
                self.pageControl.currentPage = self.currentIndex
                self.pageViewController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            }
        }
    }
    
    func turnPageToLeft() {
        
        if self.currentIndex > 0 {
            self.currentIndex--
            self.currentVC = self.viewControllerAtIndex(self.currentIndex)
            
            if self.currentVC != nil {
                
                let viewControllers: [UIViewController] = [self.currentVC]
                self.pageControl.currentPage = self.currentIndex
                self.pageViewController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
            }
        }
    }
}

//MARK: - Extensions
//MARK: - UIPageViewController Data Source and Delegate

extension BasePageVC: UIPageViewControllerDataSource {
    
    //previous VC
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! ContentPageVC).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        
        return viewControllerAtIndex(index)
    }
    
    //next VC
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! ContentPageVC).pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        
        if (index == self.pageImages.count) {
            return nil
        }
        
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> ContentPageVC?
    {
        if self.pageImages.count == 0 || index >= self.pageImages.count
        {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let pageContentViewController: ContentPageVC = self.storyboard?.instantiateViewControllerWithIdentifier("ContentPageVC") as! ContentPageVC
        pageContentViewController.imageFile = pageImages[index]
        pageContentViewController.pageIndex = index
        self.currentIndex = index
        
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return self.pageImages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return self.currentIndex
    }
}
