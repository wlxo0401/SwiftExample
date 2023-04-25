//
//  PrimaryButton.swift
//  CustomUiField
//
//  Created by 김지태 on 2023/04/19.
//

import UIKit

class PrimaryButton: UIButton {

    // 초기화
    required init?(coder: NSCoder) {
        super.init(coder: coder)!
        // 백그라운드 컬러
        self.backgroundColor = UIColor.green
        // 코너
        self.layer.cornerRadius = 8
        // 상황별 글씨 색
        self.setTitleColor(UIColor(named: "white"), for: .normal)
        self.setTitleColor(UIColor(named: "surface200"), for: .highlighted)
        self.setTitleColor(UIColor(named: "surface500"), for: .disabled)
        
        
        self.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 20)!
        self.letterSpacing = -0.4
    }
    
    // 활성화 여부
    override var isEnabled: Bool {
        didSet { updateStateUI() }
    }
    
    // 누름 여부
    override var isHighlighted: Bool {
            didSet { updateStateUI() }
    }
    
    // UI 업데이트
    private func updateStateUI() {
        switch state {
        case .normal:
            DispatchQueue.main.async {
                self.backgroundColor = UIColor(named: "primary")
            }
        case .highlighted:
            DispatchQueue.main.async {
                self.backgroundColor = UIColor(named: "primary_selected")
            }
        case .disabled:
            DispatchQueue.main.async {
                self.backgroundColor = UIColor(named: "surface100")
            }
        default:
            break
       }
    }
}

extension UIButton {
    var letterSpacing: CGFloat {
        set {
            let attributedString: NSMutableAttributedString
            if let currentAttrString = attributedTitle(for: .normal) {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            }
            else {
                attributedString = NSMutableAttributedString(string: self.title(for: .normal) ?? "")
                setTitle(.none, for: .normal)
            }

            attributedString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: NSRange(location: 0, length: attributedString.length))
            setAttributedTitle(attributedString, for: .normal)
        }
        get {
            if let currentLetterSpace = attributedTitle(for: .normal)?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            }
            else {
                return 0
            }
        }
    }
}
