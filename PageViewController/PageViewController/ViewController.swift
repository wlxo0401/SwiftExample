//
//  ViewController.swift
//  PageViewController
//
//  Created by 김지태 on 2023/04/15.
//

import UIKit

class ViewController: UIViewController {
    var pageViewController : PageViewController!
   
    var currentIndex : Int = 0 {
        didSet{
            print(currentIndex)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "PageViewController" {
            print("Connected")
            guard let vc = segue.destination as? PageViewController else {return}
            pageViewController = vc

            pageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }

        }

    }
    
    @IBAction func firstButton(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 0)
    }
    
    @IBAction func secondButton(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 1)
    }
    
    @IBAction func thirdButton(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 2)
    }
    
}

