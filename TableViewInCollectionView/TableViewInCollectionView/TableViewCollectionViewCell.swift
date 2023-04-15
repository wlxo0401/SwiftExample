//
//  TableViewCollectionViewCell.swift
//  TableViewInCollectionView
//
//  Created by 김지태 on 2023/04/15.
//

import UIKit

class TableViewCollectionViewCell: UICollectionViewCell {
   
    var tableViewCount: Int = 0
    var pageName: String = ""
    var content: [String] = []
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        self.tableView.register(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "TestTableViewCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableViewSet(count: Int, content:[String], page: String) {
        self.tableViewCount = count
        self.pageName = page
        self.content = content
        
        self.tableView.reloadData()
    }

}

extension TableViewCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TestTableViewCell", for: indexPath) as! TestTableViewCell
        
        cell.pageLabel.text = self.pageName
        cell.contentLabel.text = self.content[indexPath.row]
        
        return cell
    }
}

extension TableViewCollectionViewCell: UITableViewDelegate {
    
}
