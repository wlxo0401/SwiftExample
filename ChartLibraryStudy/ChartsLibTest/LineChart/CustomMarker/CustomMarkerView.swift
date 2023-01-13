//
//  CustomMarkerView.swift
//  ChartsLibTest
//
//  Created by 김지태 on 2023/01/11.
//

import UIKit
import Charts

class CustomMarkerView: MarkerView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var topLabel: UILabel!
  
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    private func initUI() {
        Bundle.main.loadNibNamed("CustomMarkerView", owner: self, options: nil)
        self.addSubview(contentView)
        self.offset = CGPoint(x: -(self.contentView.frame.width/2), y: 0)
        
    }
}
