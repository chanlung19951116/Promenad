//
//  PageVC.swift
//  Promenad
//
//  Created by LiuYan on 7/29/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController {

    lazy var subViewControllers: [UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sub_vc1") as! Board_SubVC1,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sub_vc2") as! Board_SubVC2,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sub_vc3") as! Board_SubVC3
        ]
    }()
    var currentIndex : Int!
    var vc: UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        setViewControllerFromIndex(index: 0)
        self.currentIndex = 0
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyBoard.instantiateViewController(withIdentifier: "boardVC") as! BoardVC
        // Do any additional setup after loading the view.
    }
    func setViewControllerFromIndex(index: Int){
        self.setViewControllers([subViewControllers[index]], direction: NavigationDirection.forward, animated: true, completion: nil)
    }
    
    
}
extension PageVC: UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = subViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard subViewControllers.count > previousIndex else {
            return nil
        }
        
        return subViewControllers[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = subViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = subViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return subViewControllers[nextIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (completed && finished) {
            if let currentVC = pageViewController.viewControllers?.last {
                let index = subViewControllers.index(of: currentVC) as! Int
                AppData.shared.index = index
                print(AppData.shared.index)
                
                //do something with index
            }
        }
    }
}
