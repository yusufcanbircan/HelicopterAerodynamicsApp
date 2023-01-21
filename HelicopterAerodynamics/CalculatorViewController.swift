//
//  CalculatorViewController.swift
//  HelicopterAerodynamics
//
//  Created by Yusuf Can Bircan.
//

import UIKit
import Foundation

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var kText: UITextField!
    @IBOutlet weak var rhoText: UITextField!
    @IBOutlet weak var gText: UITextField!
    @IBOutlet weak var piText: UITextField!
    
    @IBOutlet weak var NbText: UITextField!
    @IBOutlet weak var RText: UITextField!
    @IBOutlet weak var cText: UITextField!
    @IBOutlet weak var mText: UITextField!
    @IBOutlet weak var omegaText: UITextField!
    @IBOutlet weak var ClmeanText: UITextField!
    @IBOutlet weak var Cd0Text: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        kText.text = "1.1"
        rhoText.text = "1.225"
        gText.text = "9.81"
        piText.text = "3.14"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult" {
            if let isHover = sender as? Bool {
                let vc = segue.destination as! ResultViewController
                vc.isHover = isHover
            }
        }
    }

    // MARK: -
    
    
    @IBAction func calculateButton(_ sender: Any) {
        if let Nb = Double(NbText.text!),
           let R = Double(RText.text!),
           let c = Double(cText.text!),
           let m = Double(mText.text!),
           let omega = Double(omegaText.text!),
           let Clmean = Double(ClmeanText.text!),
           let Cd0 = Double(Cd0Text.text!),
           let k = Double(kText.text!),
           let rho = Double(rhoText.text!),
           let g = Double(gText.text!),
           let pi = Double(piText.text!){
            let isHover: Bool = calculator(Nb: Nb, R: R, c: c, m: m, omega: omega, Clmean: Clmean, Cd0: Cd0, k: k, rho: rho, g: g, pi: pi)
            HoverDao().addHover(Nb: Nb, R: R, c: c, m: m, omega: omega, Clmean: Clmean, Cd0: Cd0, k: k, rho: rho, g: g, pi: pi, isHover: isHover ? 1 : 0)
            performSegue(withIdentifier: "toResult", sender: isHover)
            
        } else {
            textFieldAlert()
        }
    }
    
    @IBAction func savedDatas(_ sender: Any) {
        performSegue(withIdentifier: "toSaved", sender: nil)
    }
    
    @IBAction func informationButton(_ sender: Any) {
        
        informationAlert()
    }
}

extension CalculatorViewController {
    
    func informationAlert() {
        let alertController = UIAlertController(title: "About Variables", message: "Symbols & Abbreviations\n\nA:     Area of the actuator disk/rotor\nAinf:  Slipstream area far below the disk\nVi:    Induced Velocity at the disk\nw:     velocity far below the disk\nT:     Thrust acting on the disk\nQ:     Torque\nP:     Power needed to create the thrust [Watt]\nDL:    Disk loading = T/A\nPL:    Power loading = T/P\nFOM:   Figure of Merit\nPo:    Profile Power\nk:     induced loss factor\nVtip:  Blade tip tangential velocity\nsigma: solidity\n\nVc:    Climb velocity\nNb: Number of Blades\nR: Blade span\nc: Blade chord\nomega: Rotational speed of the blade [rps]\nCl: lift coeff of airfoil\nCd: drag coeff of airfoil\nrho : air density\n\nNon-Dimensional Parameters\n\nVi -> lambda: Inflow ratio\nT -> CT: Thrust Coefficient\nP -> CP: Power Coefficient\nPo -> CPo: Profile Power Coeff", preferredStyle: .actionSheet)
        
        let okeyAction = UIAlertAction(title: "Okay", style: .destructive) { action in }
        alertController.addAction(okeyAction)
        
        self.present(alertController, animated: true)
    }
    
    func textFieldAlert() {
        let alertController = UIAlertController(title: "Alert", message: "All input areas must be filled and they must be a number!", preferredStyle: .alert)
                
                let okeyAction = UIAlertAction(title: "Okay", style: .destructive) { action in
                   
                }
                alertController.addAction(okeyAction)
                
                self.present(alertController, animated: true)
    }
    
    func calculator(Nb: Double, R: Double, c: Double, m: Double, omega: Double, Clmean: Double, Cd0: Double, k: Double, rho: Double, g: Double, pi: Double) -> Bool {
        
        // Hover Calculations
        // boolean return variable
        var isHover: Bool = false
        // Constants
        let k: Double = k // loss factor
        let rho: Double = rho // [kg/m3] - can be changed according to altitude
        let g: Double = g // gravity acc [m/s2]
        let pi: Double = pi

        // Calculations
        // Conservation Laws - Momentum Theory
        let A: Double = pi * pow(Double(R), 2) // Area of the rotor [m2]
        let T: Double = m * g // Thrust equals to weight in hover condition
        let Vi: Double = pow(Double(T / (2 * rho * A)),0.5) // [m/s]
        let P: Double  = (pow(Double(T), 1.5)) / (pow(Double(2 * rho * A), 0.5)) // [W]
        let w: Double = 2 * Vi
        let Ainf: Double = A / 2  // [m2]
        var DL: Double = T / A
        var PL: Double = T / P
        var Vtip: Double = omega * R
        var lambda: Double = Vi / Vtip
        var CT: Double = T / (rho * A * pow(Double(Vtip),2))
        var CP: Double = P / (rho * A * pow(Double(Vtip),3))

        // Blade Element Theory
        var sigma: Double = Nb * c / (pi * R)
        var Q_bem: Double = Nb * rho * pow(Double(omega),2) * c * Cd0 * pow(Double(R),4) / 8 // Total Torque from bem
        var Po: Double = Q_bem * omega // Profile Power
        var T_bem: Double = Nb * rho * pow(Double(omega),2) * c * pow(Double(R),3) * Clmean // Total thrust from bem
        var CT_bem: Double = sigma * Clmean / 6
        var FOM: Double = P / (k * P + Po)    // Po, Profile Power, is the power required to move an object // through a viscous medium

        if T_bem >= T {
            isHover = true
        } else {
            isHover = false
        }
        
        return isHover
    }
}
