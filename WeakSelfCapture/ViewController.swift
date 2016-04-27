//
//  ViewController.swift
//  WeakSelfCapture
//
//  Created by Doug Mead on 4/27/16.
//  Copyright © 2016 Doug Mead. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var weakSelfA: WeakSelf! = WeakSelf()
        
        weakSelfA.runBlock()
        print("reached A \(weakSelfA.instanceProp)")
        
        sleep(2)
        print("reached B \(weakSelfA.instanceProp)")
        
        sleep(2)
        weakSelfA = nil
        print("reached C (deinit)")
        
        sleep(2)
        print("reached D")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


class WeakSelf {
    
    var block: (()->())!
    var instanceProp: Int = 0
    
    init() {
        print("init")
        
        self.block = { ()->() in
//        self.block = { [weak self] ()->() in
        
            self.block = nil
            
            while self.instanceProp < 10 {
                self.instanceProp += 1
                print("\(self.instanceProp) second")
                sleep(1)
            }
            
//            while self?.instanceProp < 10 && self != nil {
//                self?.instanceProp += 1
//                print("\(self?.instanceProp) second")
//                sleep(1)
//            }
            
//            var counter = 0
//            while counter < 10 {
//                counter += 1
//                print("\(counter) second")
//                sleep(1)
//            }
            
            print("block end")
            
        }
    }
    
    deinit {
        print("**deinit**")
    }
    
    func runBlock() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), self.block)
    }
    
}







