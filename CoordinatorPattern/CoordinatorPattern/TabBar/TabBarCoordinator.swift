//
//  TabBarCoordinator.swift
//  CoordinatorPattern
//
//  Created by 김지태 on 10/27/23.
//

import Foundation
import UIKit


enum TabBarPage {
    case ready
    case steady
    case go

    init?(index: Int) {
        switch index {
        case 0:
            self = .ready
        case 1:
            self = .steady
        case 2:
            self = .go
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .ready:
            return "Ready"
        case .steady:
            return "Steady"
        case .go:
            return "Go"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .ready:
            return 0
        case .steady:
            return 1
        case .go:
            return 2
        }
    }

    // Add tab icon value
    func pageIcon() -> UIImage {
        switch self {
        case .ready:
            return UIImage(systemName: "square.and.arrow.down.fill")!
        case .steady:
            return UIImage(systemName: "pencil")!
        case .go:
            return UIImage(systemName: "scribble.variable")!
        }
    }
    
    // Add tab icon selected / deselected color
    func pageSelectedColor() -> UIColor {
        switch self {
        case .ready:
            return .red
        case .steady:
            return .blue
        case .go:
            return .green
        }
    }

    func pageDeSelectedColor() -> UIColor {
        switch self {
        case .ready:
            return .purple
        case .steady:
            return .orange
        case .go:
            return .yellow
        }
    }
    
    // etc
}

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabCoordinator: NSObject, Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
        
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController
    
    var tabBarController: UITabBarController

    var type: CoordinatorType { .tab }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    func start() {
        // Let's define which pages do we want to add into tab bar
        let pages: [TabBarPage] = [.go, .steady, .ready]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        // Initialization of ViewControllers or these pages
        let controllers: [UINavigationController] = pages.map({ self.getTabController($0) })
        
        self.prepareTabBarController(withTabControllers: controllers)
    }
    
    deinit {
        print("TabCoordinator deinit")
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        // Set delegate for UITabBarController
        self.tabBarController.delegate = self
        // Assign page's controllers
        self.tabBarController.setViewControllers(tabControllers, animated: true)
        // Let set index
        self.tabBarController.selectedIndex = TabBarPage.ready.pageOrderNumber()
        // Styling
        self.tabBarController.tabBar.isTranslucent = false
        // 선택했을 때 색상
        self.tabBarController.tabBar.tintColor = .black
        // 선택 안되었을 때 색상
        self.tabBarController.tabBar.unselectedItemTintColor = .gray
        
        // 탭바 배경색상
        self.tabBarController.tabBar.backgroundColor = .white
        
        
        // In this step, we attach tabBarController to navigation controller associated with this coordanator
        self.navigationController.viewControllers = [self.tabBarController]
    }
    
    // Controller 생성
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)

        let tabBarItem: UITabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                         image: page.pageIcon(),
                                                         tag: page.pageOrderNumber())
        
        
        navController.tabBarItem = tabBarItem

        switch page {
        case .ready:
            // If needed: Each tab bar flow can have it's own Coordinator.
            let readyVC = ReadyViewController()
//            readyVC.didSendEventClosure = { [weak self] event in
//                switch event {
//                case .ready:
//                    self?.selectPage(.steady)
//                }
//            }
                        
            navController.pushViewController(readyVC, animated: true)
        case .steady:
            let steadyVC = SteadyViewController()
//            steadyVC.didSendEventClosure = { [weak self] event in
//                switch event {
//                case .steady:
//                    self?.selectPage(.go)
//                }
//            }
            
            navController.pushViewController(steadyVC, animated: true)
        case .go:
            let goVC = GoViewController()
//            goVC.didSendEventClosure = { [weak self] event in
//                switch event {
//                case .go:
//                    self?.finish()
//                }
//            }
            
            navController.pushViewController(goVC, animated: true)
        }
        
        return navController
    }
    
    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

// MARK: - UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        // Some implementation
    }
}
