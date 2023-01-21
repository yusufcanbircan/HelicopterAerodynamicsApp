//
//  ViewController.swift
//  HelicopterAerodynamics
//
//  Created by Yusuf Can Bircan.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var imageViewUp: UIImageView!
    @IBOutlet weak var imageViewDown: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //// Copying Sql Database to Device
        copyDatabase()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        imageViewUp.image = UIImage(named: "Knife")
        imageViewDown.image = UIImage(imageLiteralResourceName: "Body")
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [.curveEaseIn],
                           animations: {
                self.imageViewUp.transform = CGAffineTransform(scaleX: 0.05, y: 1)
            },
                           completion: {(true) in
                UIView.animate(withDuration: 0.5,
                               delay: 0,
                               options: [.curveEaseIn],
                               animations: {
                    self.imageViewUp.transform = CGAffineTransform(scaleX: 1, y: 1)
                },
                               completion: {(true) in
                    UIView.animate(withDuration: 0.5,
                                   delay: 0,
                                   options: [.repeat, .autoreverse, .curveEaseIn],
                                   animations: {
                        self.imageViewUp.transform = CGAffineTransform(scaleX: 0.05, y: 1)
                    },
                                   completion: nil)
                })
            })
        }
    }
}


// MARK: Home Screen Worker Extension
extension ViewController {
    func copyDatabase() {
        let bundlePath = Bundle.main.path(forResource: "HelicopterAerodynamics", ofType: ".sqlite")
        
        let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let copyDestination = URL(fileURLWithPath: destinationPath).appending(path: "HelicopterAerodynamics.sqlite")
        
        if !FileManager.default.fileExists(atPath: copyDestination.path()){
            
            do {
                
                try FileManager.default.copyItem(atPath: bundlePath!, toPath: copyDestination.path())
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}


