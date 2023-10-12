//
//  ScondViewController.swift
//  ffffff
//
//  Created by 김지태 on 2023/07/30.
//

import UIKit

class ScondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.dataSource = self
        
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        // Do any additional setup after loading the view.
    }
}



extension ScondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.label.text = "\(indexPath.row)번 채팅방"
        return cell
    }
}
