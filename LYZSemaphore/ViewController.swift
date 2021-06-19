//
//  ViewController.swift
//  LYZSemaphore
//
//  Created by 刘耀宗 on 2021/6/19.
//

import UIKit

class ViewController: UIViewController {

    //票的总数
    var total: Int = 20
    
    var lock: NSLock = NSLock()
    
    let sem = DispatchSemaphore(value: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        syncDemo()
       
        
    }
    
    func demo1() {
        //全局队列,并发
        let queue = DispatchQueue.global()
        var index: Int = 0
        for _ in 0...10 {
            queue.async {
                //如果信号量>0 .那么信号量-1 .执行下句代码
                self.sem.wait()
                self.soldTicket()
                //信号量+1
                self.sem.signal()
            }
            index += 1
        }
    }
    
    //卖票
    func soldTicket() {
        sleep(1)
        total -= 1;
        print("卖掉一张票,剩余\(total)张")
    }
    
    
    func syncDemo() {
        var index: Int = 0
        let queue = DispatchQueue.global()
        for _ in 0...10 {
            self.sem.wait()
            queue.async {
                let queue = DispatchQueue(label: "")
                queue.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                    print("index = \(index)");
                    self.sem.signal()
                })
            }
            index += 1
        }
    }
    


}

