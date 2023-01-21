//
//  HoverDao.swift
//  HelicopterAerodynamics
//
//  Created by Yusuf Can Bircan.
//

import Foundation

class HoverDao {
    var db: FMDatabase?
    
    init() {
        let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let databaseURL = URL(fileURLWithPath: destinationPath).appending(path: "HelicopterAerodynamics.sqlite")
        
        db = FMDatabase(path: databaseURL.path())
    }
    
    func fetchAllData() -> [Hover] {
        var hoverList: [Hover] = [Hover]()
        
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM Hover", values: nil)
            
            while rs.next() {
                let hover = Hover(calculation_id: Int(rs.string(forColumn: "calculation_id"))!,
                                  Nb: Double(rs.string(forColumn: "Nb"))!,
                                  R: Double(rs.string(forColumn: "R"))!,
                                  c: Double(rs.string(forColumn: "c"))!,
                                  m: Double(rs.string(forColumn: "m"))!,
                                  omega: Double(rs.string(forColumn: "omega"))!,
                                  Clmean: Double(rs.string(forColumn: "Clmean"))!,
                                  Cd0: Double(rs.string(forColumn: "Cd0"))!,
                                  k: Double(rs.string(forColumn: "k"))!,
                                  rho: Double(rs.string(forColumn: "rho"))!,
                                  g: Double(rs.string(forColumn: "g"))!,
                                  pi: Double(rs.string(forColumn: "pi"))!,
                                  isHover: Int(rs.string(forColumn: "isHover"))!
                )
                
                hoverList.append(hover)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return hoverList
    }
    
    func fetchTheId(hoverId: Int) -> Hover {
        
        var hover = Hover()
        
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM Hover WHERE calculation_id = ?", values: [hoverId])
            
            while rs.next() {
                let hoverRs = Hover(calculation_id: Int(rs.string(forColumn: "calculation_id"))!,
                                  Nb: Double(rs.string(forColumn: "Nb"))!,
                                  R: Double(rs.string(forColumn: "R"))!,
                                  c: Double(rs.string(forColumn: "c"))!,
                                  m: Double(rs.string(forColumn: "m"))!,
                                  omega: Double(rs.string(forColumn: "omega"))!,
                                  Clmean: Double(rs.string(forColumn: "Clmean"))!,
                                  Cd0: Double(rs.string(forColumn: "Cd0"))!,
                                  k: Double(rs.string(forColumn: "k"))!,
                                  rho: Double(rs.string(forColumn: "rho"))!,
                                  g: Double(rs.string(forColumn: "g"))!,
                                  pi: Double(rs.string(forColumn: "pi"))!,
                                  isHover: Int(rs.string(forColumn: "isHover"))!
                )
                
                hover = hoverRs
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        
        return hover
    }
    
    func addHover(Nb: Double, R: Double, c: Double, m: Double, omega: Double, Clmean: Double, Cd0: Double, k: Double, rho: Double, g: Double, pi: Double, isHover: Int) {
        //let counter: Int = HoverDao().fetchAllData().count
        
        db?.open()
        
        do {
            
            try db!.executeUpdate("INSERT INTO Hover(Nb, R, c, m, omega, Clmean, Cd0, k, rho, g, pi, isHover) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", values: [Nb, R, c, m, omega, Clmean, Cd0, k, rho, g, pi, isHover])
            
        }catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
    func deleteHover(calculation_id: Int) {
        
        db?.open()
        
        do {
            
            try db!.executeUpdate("DELETE FROM Hover WHERE calculation_id = ?", values: [calculation_id])
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
