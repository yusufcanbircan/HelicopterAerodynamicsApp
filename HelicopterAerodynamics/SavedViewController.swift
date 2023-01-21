//
//  SavedViewController.swift
//  HelicopterAerodynamics
//
//  Created by Yusuf Can Bircan.
//

import UIKit

class SavedViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [Hover]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        data = HoverDao().fetchAllData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult"{
            if let isHover = sender as? Int {
                let vc = segue.destination as! ResultViewController
                if isHover == 1 {
                    vc.isHover = true
                } else if isHover == 0 {
                    vc.isHover = false
                }
            }
        }
    }

}

extension SavedViewController: UITableViewDelegate, UITableViewDataSource, SavedTableViewCellProtocol {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hover = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath) as! SavedTableViewCell
        
        cell.idLabel.text = "\(String(describing: hover.calculation_id!))"
        if hover.isHover == 1 {
            cell.informationLabel.text = "Can Hover"
        } else if hover.isHover == 0 {
            cell.informationLabel.text = "Cannot Hover"
        }
        
        cell.cellProtocol = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete", handler: {(contextualAction, view, boolValue) in
            let deleteId = self.data[indexPath.row].calculation_id
                
            HoverDao().deleteHover(calculation_id: deleteId!)
            
            self.data = HoverDao().fetchAllData()
                
            self.tableView.reloadData()
            })
                
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let alertController = UIAlertController(title: "Information About Calculation", message: "Calculation Id - \(data[indexPath.row].calculation_id!)\nNb - \(data[indexPath.row].Nb!)\nR - \(data[indexPath.row].R!)\nc - \(data[indexPath.row].c!)\nm - \(data[indexPath.row].m!)\nomega - \(data[indexPath.row].omega!)\nClmean - \(data[indexPath.row].Clmean!)\nCd0 - \(data[indexPath.row].Cd0!)\nk - \(data[indexPath.row].k!)", preferredStyle: .actionSheet)
                
                let okeyAction = UIAlertAction(title: "Okay", style: .destructive) { action in
                   
                }
                alertController.addAction(okeyAction)
                
                self.present(alertController, animated: true)
    }
    
    func executeAgainButtonTapped(indexPath: IndexPath) {
        let hover = data[indexPath.row]
        
        performSegue(withIdentifier: "toResult", sender: hover.isHover)
    }
    
    
}
