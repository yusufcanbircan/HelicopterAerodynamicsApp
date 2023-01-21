//
//  Hover.swift
//  HelicopterAerodynamics
//
//  Created by Yusuf Can Bircan.
//

import Foundation

class Hover {
    var calculation_id: Int?
    var Nb: Double?
    var R: Double?
    var c: Double?
    var m: Double?
    var omega: Double?
    var Clmean: Double?
    var Cd0: Double?
    var k: Double?
    var rho: Double?
    var g: Double?
    var pi: Double?
    var isHover: Int?
    
    init() {
        
    }
    
    init(calculation_id: Int, Nb: Double, R: Double, c: Double, m: Double, omega: Double, Clmean: Double, Cd0: Double, k: Double, rho: Double, g: Double, pi: Double, isHover: Int) {
        
        self.calculation_id = calculation_id
        self.Nb = Nb
        self.R = R
        self.c = c
        self.m = m
        self.omega = omega
        self.Clmean = Clmean
        self.Cd0 = Cd0
        self.k = k
        self.rho = rho
        self.g = g
        self.pi = pi
        self.isHover = isHover
    }
}
