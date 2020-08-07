//
//  GcdVC.swift
//  GcdOperationDemo
//
//  Created by Yuni on 2020/8/7.
//  Copyright © 2020 Yuni. All rights reserved.
//

import UIKit

class GcdVC: UIViewController {
    @IBOutlet weak var txtView: UITextView!
    private var textList:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "GCD"
        textList.removeAll()
    }
    
    @IBAction func serialBtnPressed(_ sender: Any) {
        printTextBySerial()
    }
    
    @IBAction func concurrentBtnPressed(_ sender: Any) {
        printTextByConcurrent()
    }
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        textList.removeAll()
        self.txtView.text = ""
    }
    
    private func updateTextList(_ text: String) {
        OperationQueue.main.addOperation { [weak self] in // different with DispatchQueue.main.async
//        DispatchQueue.main.async { [weak self] in
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
    
    private func printTextBySerial() {
        let serialQueue = DispatchQueue(label: "com.ywraccoon.serial.queue")
        serialQueue.async { [weak self] in
            let text = "[serialQueue] " + "1"
            self?.updateTextList(text)
        }

        serialQueue.async { [weak self] in
            let text = "[serialQueue] " + "2"
            self?.updateTextList(text)
        }
        
        serialQueue.async { [weak self] in
            let text = "[serialQueue] " + "3"
            self?.updateTextList(text)
        }

        serialQueue.async { [weak self] in
            let text = "[serialQueue] " + "4"
            self?.updateTextList(text)
        }
    }
    
    private func printTextByConcurrent() {
        let concurrentQueue = DispatchQueue(label: "com.ywraccoon.concurrent.queue", attributes: .concurrent)
        concurrentQueue.async { [weak self] in
            let text = "[concurrentQueue] " + "1"
            self?.updateTextList(text)
        }

        concurrentQueue.async { [weak self] in
            let text = "[concurrentQueue] " + "2"
            self?.updateTextList(text)
        }

        concurrentQueue.async { [weak self] in
            let text = "[concurrentQueue] " + "3"
            self?.updateTextList(text)
        }

        concurrentQueue.async { [weak self] in
            let text = "[concurrentQueue] " + "4"
            self?.updateTextList(text)
        }
    }
}
