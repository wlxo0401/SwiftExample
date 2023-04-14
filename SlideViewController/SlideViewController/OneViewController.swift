//
//  OneViewController.swift
//  SlideViewController
//
//  Created by 김지태 on 2023/04/13.
//

import UIKit

class OneViewController: UIViewController {
    
    lazy var navigationView: UIView = {
            let view = UIView()
            view.backgroundColor = .lightGray

            return view
        }()
    
    lazy var vc1: UIViewController = {
        let vc = TwoViewController()

        return vc
    }()

    lazy var vc2: UIViewController = {
        let vc = ThreeViewController()
        return vc
    }()

    
    lazy var dataViewControllers: [UIViewController] = {
        return [vc1, vc2]
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad : 1111111111111")
    }
    
    
    private func configure() {
            view.addSubview(navigationView)
            addChild(pageViewController)
            view.addSubview(pageViewController.view)

            navigationView.snp.makeConstraints { make in
                make.width.top.equalToSuperview()
                make.height.equalTo(72)
            }

            pageViewController.view.snp.makeConstraints { make in
                make.top.equalTo(navigationView.snp.bottom)
                make.leading.trailing.bottom.equalToSuperview()
            }
            pageViewController.didMove(toParent: self)

        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear : 1111111111111")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear : 1111111111111")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear : 1111111111111")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear : 1111111111111")
    }
}
