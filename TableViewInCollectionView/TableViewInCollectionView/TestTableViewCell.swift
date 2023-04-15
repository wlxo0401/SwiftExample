//
//  TestTableViewCell.swift
//  TableViewInCollectionView
//
//  Created by 김지태 on 2023/04/15.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    @IBOutlet weak var pageLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
