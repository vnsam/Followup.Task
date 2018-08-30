//
//  OfferPageViewController.swift
//  FollowUpTask
//
//  Created by Narayanasamy, Vignesh on 2/18/18.
//  Copyright © 2018 Narayanasamy, Vignesh. All rights reserved.
//

import UIKit

private struct Count {
    static let singleCount = 1
}

private struct AutoScroll {
    static let interval = 3.0
}

class OfferPageViewController: UIPageViewController {
    
    //  MARK:-  Properties
    fileprivate var offerImageViewController: OfferImageViewController?
    fileprivate var imagePaths:[String] = []
    fileprivate var currentIndex = 0
    fileprivate var timer: Timer?   //  Timer as a property to avoid redundant addition of timers
    
    //  MARK:-  Custom Initializer
    init(imagePaths: [String]) {
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal,
                   options: nil)
        
        self.imagePaths = imagePaths
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK:-  View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollNext()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//  MARK:-  New Instance
extension OfferPageViewController {
    static func newInstance(imagePaths: [String]) -> OfferPageViewController {
        let offerPageViewController = OfferPageViewController
            .init(imagePaths: imagePaths)
        return offerPageViewController
    }
}

//  MARK:-  UI Setup
extension OfferPageViewController {
    
    fileprivate func setupUI() {
        setupPageViewController()
    }
    
    fileprivate func setupPageViewController() {
        dataSource = self
        delegate = self
        
        setViewControllers([getViewControllerAtIndex(0)],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
    
    @objc dynamic fileprivate func setViewControllersToPageViewController() {
        
        calculateIndex()
        
        setViewControllers([getViewControllerAtIndex(currentIndex)],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        
    }
    
    fileprivate func calculateIndex() {
        
        if currentIndex < imagePaths.count - Count.singleCount {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
    }
}

//  MARK:-  Custom functions
extension OfferPageViewController {
    fileprivate func getViewControllerAtIndex(_ index: Int) -> OfferImageViewController {
        
        let offerImageViewController = OfferImageViewController.newInstance()
        offerImageViewController.setImage(imagePaths[index], at: index)
        
        return offerImageViewController
    }
}

//  MARK:-  UIPageViewControllerDataSource
extension OfferPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as? OfferImageViewController)?.index ?? 0
        
        currentIndex = index
        
        if index == 0 {
            return getViewControllerAtIndex(imagePaths.count - 1)
        }
        
        index -= 1
        return getViewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as? OfferImageViewController)?.index ?? 0
        
        currentIndex = index
        index += 1
        
        if index == imagePaths.count {
            return getViewControllerAtIndex(0)
        }
        
        return getViewControllerAtIndex(index)
    }
    
}

//  MARK:-  UIPageViewControllerDelegate
extension OfferPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        timer?.invalidate()
        timer = nil
        scrollNext()
        
    }
}

//  MARK:-  AutoScorll functionality
extension OfferPageViewController {
    fileprivate func scrollNext() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: AutoScroll.interval, target: self, selector: #selector(setViewControllersToPageViewController), userInfo: nil, repeats: true)
            //  TODO:-  Should add timer, to currentrunloop? Inspect - | for app background support |
        }
    }
}
