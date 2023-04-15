//
//  ViewController.swift
//  TableViewInCollectionView
//
//  Created by 김지태 on 2023/04/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var carouselCollectionView: UICollectionView!
    
    // in ViewController
    private enum Const {
        static let itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 40)
        static let itemSpacing = 0.0

        static var insetX: CGFloat = 0

        static var collectionViewContentInset: UIEdgeInsets {
            UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
        }
    }

    

    // in ViewController
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Const.itemSize // <-
        layout.minimumLineSpacing = Const.itemSpacing // <-
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    private func carouselCollectionViewInit() {
        self.carouselCollectionView.collectionViewLayout = self.collectionViewFlowLayout
        self.carouselCollectionView.isScrollEnabled = true
        self.carouselCollectionView.showsHorizontalScrollIndicator = false
        self.carouselCollectionView.showsVerticalScrollIndicator = true
        self.carouselCollectionView.clipsToBounds = true
        // 운행 예정 활성화 카드
        self.carouselCollectionView.register(UINib(nibName: "TableViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TableViewCollectionViewCell")
        
        self.carouselCollectionView.isPagingEnabled = false // <- 한 페이지의 넓이를 조절 할 수 없기 때문에 scrollViewWillEndDragging을 사용하여 구현
        self.carouselCollectionView.contentInsetAdjustmentBehavior = .never // <- 내부적으로 safe area에 의해 가려지는 것을 방지하기 위해서 자동으로 inset조정해 주는 것을 비활성화
        self.carouselCollectionView.contentInset = Const.collectionViewContentInset // <-
        self.carouselCollectionView.decelerationRate = .fast // <- 스크롤이 빠르게 되도록 (페이징 애니메이션같이 보이게하기 위함)
        self.carouselCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.carouselCollectionViewInit()
        self.carouselCollectionView.dataSource = self
        self.carouselCollectionView.delegate = self
    }

    @IBAction func aButtonAction(_ sender: Any) {
        let indexPath = IndexPath(row: 0, section: 0)
        self.carouselCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)

    }
    
    @IBAction func bButtonAction(_ sender: Any) {
        let indexPath = IndexPath(row: 1, section: 0)
        self.carouselCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
    }
    

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.carouselCollectionView.dequeueReusableCell(withReuseIdentifier: "TableViewCollectionViewCell", for: indexPath) as! TableViewCollectionViewCell
        
        if indexPath.row == 0 {
            cell.pageName = "A"
            cell.tableViewCount = 20
            
            var content: [String] = []
            for num in Range(0 ... 19) {
                content.append("\(num)번 Cell입니다.")
            }
            cell.content = content
            cell.tableView.backgroundColor = .red
        } else {
            cell.pageName = "B"
            cell.tableViewCount = 50
            
            var content: [String] = []
            for num in Range(0 ... 49) {
                content.append("\(num)번 Cell입니다.")
            }
            
            cell.content = content
            cell.tableView.backgroundColor = .blue
        }
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = Const.itemSize.width + Const.itemSpacing
        let index = round(scrolledOffsetX / cellWidth)
        
        
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
}

