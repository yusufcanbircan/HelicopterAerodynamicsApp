//
//  ResultViewController.swift
//  HelicopterAerodynamics
//
//  Created by Yusuf Can Bircan.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var imageViewUp: UIImageView!
    @IBOutlet weak var imageViewDown: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var isHover: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewUp.image = UIImage(named: "Knife")
        imageViewDown.image = UIImage(imageLiteralResourceName: "Body")
        
        if let isHover {
            if isHover {
                hoverTrue()
                resultLabel.text = "The Helicopter can hover!"
                resultLabel.textColor = .systemGreen
            } else {
                resultLabel.text = "The Helicopter cannot hover!"
                resultLabel.textColor = .red
                hoverFalse()
            }
        }

    }
    
    @IBAction func newCalculationButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    

}

extension ResultViewController {
    
    func hoverFalse(){
        UIView.animate(withDuration: 2,
                       delay: 1,
                       options: [/*.repeat, .autoreverse,*/ .curveEaseInOut],
                       animations: {
            
            let x = CGAffineTransform(scaleX: 0.05, y: 1)
            let y = CGAffineTransform(translationX: 0, y: -150)
            self.imageViewUp.transform = x.concatenating(y)
            self.imageViewDown.transform = CGAffineTransform(translationX: 0, y: -150)
            
        },
                       completion: { (true) in
            UIView.animate(withDuration: 0.8,
                           delay: 0,
                           options: [/*.repeat, .autoreverse,*/ .curveEaseInOut],
                           animations: {
                
                self.imageViewUp.transform = CGAffineTransform(translationX: 0, y: 50)
                self.imageViewDown.transform = CGAffineTransform(translationX: 0, y: 50)
                
            },
                           completion: { (true) in
                UIView.animate(withDuration: 0.5,
                               delay: 0,
                               options: [/*.repeat, .autoreverse,*/ .curveEaseInOut],
                               animations: {
                    
                    self.imageViewUp.transform = CGAffineTransform(translationX: 0, y: -25)
                    self.imageViewDown.transform = CGAffineTransform(translationX: 0, y: -25)
                    
                },
                               completion: {(true) in
                    UIView.animate(withDuration: 0.4,
                                   delay: 0,
                                   options: [/*.repeat, .autoreverse,*/ .curveEaseIn],
                                   animations: {
                        
                        self.imageViewUp.transform = CGAffineTransform(translationX: 0, y: 25)
                        self.imageViewDown.transform = CGAffineTransform(translationX: 0, y: 25)
                        
                    },
                                   completion: nil)
                })
            })
        })
    }
    
    func hoverTrue() {
        
        UIView.animate(withDuration: 1.5,
                       delay: 0.7,
                       options: [/*.repeat, .autoreverse,*/ .curveEaseInOut],
                       animations: {
            
            let x = CGAffineTransform(scaleX: 0.05, y: 1)
            let y = CGAffineTransform(translationX: 0, y: -100)
            self.imageViewUp.transform = x.concatenating(y)
            self.imageViewDown.transform = CGAffineTransform(translationX: 0, y: -100)
            
        },
                       completion: { (true) in
            UIView.animate(withDuration: 0.8,
                           delay: 0,
                           options: [.repeat, .autoreverse, .curveEaseInOut],
                           animations: {
                
                let x = CGAffineTransform(scaleX: 1, y: 1)
                let y = CGAffineTransform(translationX: 0, y: -10)
                self.imageViewUp.transform = x.concatenating(y)
                self.imageViewDown.transform = CGAffineTransform(translationX: 0, y: -10)
                
            },
                           completion: nil )
        })
        
    }
}
