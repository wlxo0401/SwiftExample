//
//  Coordinator.swift
//  CoordinatorPattern
//
//  Created by 김지태 on 10/27/23.
//

import Foundation

import UIKit

protocol Coordinator: AnyObject {
    
    /// 부모 코디네이터가 자식이 finish 됐을 때 알 수 있도록 돕는 delegate 프로토콜
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    /// 각각의 코디네이터는 하나의 네비게이션 컨트롤러를 가지고 있습니다.
    var navigationController: UINavigationController { get set }
    /// 모든 하위 코디네이터를 가지고 추적하는 배열, 대부분의 경우 이 배열에는 하위 코디네이터가 하나만 포함됩니다.
    var childCoordinators: [Coordinator] { get set }
    /// 코디네이터 타입
    var type: CoordinatorType { get }
    
    init(_ navigationController: UINavigationController)
    
    func start()
    func finish()
}

extension Coordinator {
    
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
 
// MARK: - CoordinatorOutput
/// Delegate protocol helping parent Coordinator know when its child is ready to be finished.
protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

// MARK: - CoordinatorType
/// Using this structure we can define what type of flow we can use in-app.
enum CoordinatorType {
    case app, login, tab
}
