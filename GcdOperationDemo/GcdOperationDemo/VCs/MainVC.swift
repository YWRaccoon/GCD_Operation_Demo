//
//  MainVC.swift
//  GcdOperationDemo
//
//  Created by Yuni on 2020/8/7.
//  Copyright © 2020 Yuni. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func gcdBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "GcdVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func operationBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "OperationVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
