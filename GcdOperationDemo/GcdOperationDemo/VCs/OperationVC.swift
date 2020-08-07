//
//  OperationVC.swift
//  GcdOperationDemo
//
//  Created by Yuni on 2020/8/7.
//  Copyright © 2020 Yuni. All rights reserved.
//

import UIKit

class OperationVC: UIViewController {
    @IBOutlet weak var txtView: UITextView!
    private var textList:[String] = [String]()
    var queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Operation"
        textList.removeAll()
    }
    
    @IBAction func normalBtnPressed(_ sender: Any) {
        printTextByNormal()
    }
    
    @IBAction func dependency2ByBlockBtnPressed(_ sender: Any) {
        printTextByDependency2Block()
    }
    
    @IBAction func stopBtnPressed(_ sender: Any) {
        queue.cancelAllOperations()
    }
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        textList.removeAll()
        self.txtView.text = ""
    }
    
    private func updateTextList(_ text: String) {
        DispatchQueue.main.async { [weak self] in
            guard let txtView = self?.txtView else { return }
            self?.textList.append(text)
            var text = ""
            self?.textList.forEach({text = text + $0 + "\n\n"})
            txtView.text = text
            if txtView.text.count > 0 {
                let location = txtView.text.count - 1
                let bottom = NSMakeRange(location, 1)
                txtView.scrollRangeToVisible(bottom)
            }
        }
    }
    
    private func printTextByNormal() {
        queue = OperationQueue()
        queue.addOperation { [weak self] in
            print("[normal] " + "1")
            let text = "[normal] " + "1"
            self?.updateTextList(text)
        }

        queue.addOperation { [weak self] in
            print("[normal] " + "2")
            let text = "[normal] " + "2"
            self?.updateTextList(text)
        }
        
        queue.addOperation { [weak self] in
            print("[normal] " + "3")
            let text = "[normal] " + "3"
            self?.updateTextList(text)
        }

        queue.addOperation { [weak self] in
            print("[normal] " + "4")
            let text = "[normal] " + "4"
            self?.updateTextList(text)
        }
    }
    
    private func printTextByDependency2Block() {
        queue = OperationQueue()
        let block2 = BlockOperation {
            print("block2")
        }
        block2.completionBlock = { [weak self] in
            let text = "[block2 completionBlock]"
            self?.updateTextList(text)
        }
        queue.addOperation(block2)
        
        let block1 = BlockOperation {
            print("block1")
        }
        block1.completionBlock = { [weak self] in
            let text = "[block1 completionBlock]"
            self?.updateTextList(text)
        }
        block1.addDependency(block2)
        queue.addOperation(block1)
        
        let block3 = BlockOperation {
            print("block3")
        }
        block3.completionBlock = { [weak self] in
            let text = "[block3 completionBlock]"
            self?.updateTextList(text)
        }
        block3.addDependency(block2)
        queue.addOperation(block3)
        
        let block4 = BlockOperation {
            print("block4")
        }
        block4.completionBlock = { [weak self] in
            let text = "[block4 completionBlock]"
            self?.updateTextList(text)
        }
        block4.addDependency(block2)
        queue.addOperation(block4)
    }
}
