//
//  ViewController.swift
//  SnapkitCollectionView
//
//  Created by 김지태 on 12/11/23.
//

import UIKit
import SnapKit

class BaseCollectionViewController: UIViewController {

    let bannerCollectionView: BannerCollectionView = BannerCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setUI()
    }
    
    
    private func setUI() {
        self.view.backgroundColor = .white
        
        [self.bannerCollectionView].forEach { self.view.addSubview($0) }
        
        self.setUpConstraints()
    }
    
    private func setUpConstraints() {
        self.bannerCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(150)
        }
    }
}


class BannerCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    lazy var collectionView: UICollectionView = {
        // UICollectionViewLayout을 상속한 레이아웃을 사용하거나 커스텀 레이아웃을 여기에 생성합니다.
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .brown
        cv.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        return cv
    }()
    
    // 초기화 메서드를 추가하려면 다음과 같이 작성할 수 있습니다.
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.setUI()
    }
    
    private func setUI() {
        self.backgroundColor = .red
        
        [self.collectionView].forEach { self.addSubview($0) }

        self.collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as? MyCollectionViewCell else {
            return UICollectionViewCell()
        }
                
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing : CGFloat = 10
        
        let myWidth : CGFloat = (collectionView.bounds.width - itemSpacing * 2) / 3
        
        
        return CGSize(width: myWidth, height: myWidth)
    }
}

class MyCollectionViewCell : UICollectionViewCell {
    static let identifier = "cellIdentifier"
    
    lazy var colorView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUI()
    }
    
    private func setUI() {
        self.backgroundColor = .gray
        
        [self.colorView].forEach { self.addSubview($0) }
    }
}
