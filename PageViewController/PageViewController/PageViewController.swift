//
//  PageViewController.swift
//  PageViewController
//
//  Created by 김지태 on 2023/04/15.
//

import UIKit

class PageViewController: UIPageViewController {
    
    
    let viewsList : [UIViewController] = {
            
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
       
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "OneViewController")
        let vc2 = storyBoard.instantiateViewController(withIdentifier: "TwoViewController")
        let vc3 = storyBoard.instantiateViewController(withIdentifier: "ThreeViewController")
        
        return [vc1, vc2, vc3]
        
    }()
    
    var currentIndex : Int {
        guard let vc = viewControllers?.first else { return 0 }
        return viewsList.firstIndex(of: vc) ?? 0
    }
    
    var completeHandler : ((Int)->())?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.dataSource = self
        self.delegate = self
                
        if let firstvc = viewsList.first {
            self.setViewControllers([firstvc], direction: .forward, animated: true, completion: nil)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func setViewcontrollersFromIndex(index : Int) {
        
        let pageCount: [Int] = []
        
        if index < 0 && index >= viewsList.count { return }
        print("화면 전환 시작")
        if self.currentIndex < index {
            print("num \([self.currentIndex ... index])")
            for num in Range(self.currentIndex ... index) {
                self.setViewControllers([viewsList[num]], direction: .forward, animated: true, completion: nil)
            }
            
        } else if self.currentIndex > index {
            print("num \([index ... self.currentIndex].reversed())")
            for num in Range(index ... self.currentIndex).reversed() {
                self.setViewControllers([viewsList[num]], direction: .reverse, animated: true, completion: nil)
            }
            
            
        }
        
        print("화면 전환 종료")
        completeHandler?(currentIndex)
        
    }

}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = viewsList.firstIndex(of: viewController) else {return nil}

        let previousIndex = index - 1

        if previousIndex < 0 { return nil}

        return viewsList[previousIndex]

    }

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let index = viewsList.firstIndex(of: viewController) else {return nil}

        let nextIndex = index + 1

        if nextIndex == viewsList.count { return nil}

        return viewsList[nextIndex]

    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            completeHandler?(currentIndex)
        }
    }
}
