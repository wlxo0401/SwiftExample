//
//  RootViewController.swift
//  RxSwiftMVVM
//
//  Created by 김지태 on 2023/03/10.
//

import UIKit
import RxSwift
import RxRelay

class RootViewController: UIViewController {

    
    //MARK: - Propertiese
    let disposeBag = DisposeBag()
    let viewModel: RootViewModel
    
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        cv.delegate = self
        cv.dataSource = self
        
        cv.backgroundColor = .red
        
        return cv
    }()
    
    
    private let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    var articleViewModelObserver: Observable<[ArticleViewModel]> {
        return articleViewModel.asObservable()
    }
    
    
    //MARK: - LifeCycles
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.configureCollectionView()
        self.fetchArticles()
        self.subscribe()
        print("Hi")
        // Do any additional setup after loading the view.
    }
    

    func configureUI() {
        self.view.backgroundColor = .systemBackground
        
        
        self.view.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func configureCollectionView() {
        self.collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    //MARK: - Helpers
    func fetchArticles() {
        self.viewModel.fetchArticles().subscribe(onNext: { articleViewModel in
            self.articleViewModel.accept(articleViewModel)
        }).disposed(by: self.disposeBag)
    }
    
    
    func subscribe() {
        self.articleViewModelObserver.subscribe(onNext: { articles in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }).disposed(by: self.disposeBag)
    }
    
    
}


extension RootViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articleViewModel.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ArticleCell
        
        let articleViewModel = self.articleViewModel.value[indexPath.row]
        cell.imageView.image = nil
        print(articleViewModel)
        cell.viewModel.onNext(articleViewModel)
        cell.backgroundColor = .blue
        return cell
    }
    
    
}

extension RootViewController: UICollectionViewDelegate {
    
}

extension RootViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.height, height: 120)
    }
    
}
