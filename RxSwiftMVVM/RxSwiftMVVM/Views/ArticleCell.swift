//
//  ArticleCell.swift
//  RxSwiftMVVM
//
//  Created by 김지태 on 2023/03/10.
//

import UIKit
import RxSwift
import SDWebImage

class ArticleCell: UICollectionViewCell {
    //MARK: - Properties
    let disposeBag = DisposeBag()
    var viewModel = PublishSubject<ArticleViewModel>()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFill
        iv.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 60).isActive = true
        iv.backgroundColor = .green
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        
        return lb
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 3
        lb.text = "Hi"
        return lb
    }()
    
    //MARK: - LifeCycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
        self.subscribe()
    }
    
    func subscribe() {
        self.viewModel.subscribe(onNext: { articleViewModel in
            if let urlString = articleViewModel.imageUrl {
                self.imageView.sd_setImage(with: URL(string: urlString), completed: nil)
            }
            
            self.titleLabel.text = articleViewModel.title
            self.descriptionLabel.text = articleViewModel.description
            
        }).disposed(by: self.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configures
    func configureUI() {
        self.backgroundColor = .systemBackground
        
        self.addSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        self.imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.imageView.topAnchor).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 20).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40).isActive = true
        
        
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor).isActive = true
        self.descriptionLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor).isActive = true
        
    }
}
