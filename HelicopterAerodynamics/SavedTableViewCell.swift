//
//  SavedTableViewCell.swift
//  HelicopterAerodynamics
//
//  Created by Yusuf Can Bircan.
//

import UIKit


protocol SavedTableViewCellProtocol {
    func executeAgainButtonTapped(indexPath: IndexPath)
}

class SavedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    
    var cellProtocol: SavedTableViewCellProtocol?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func executeButtonTapped(_ sender: Any) {
        cellProtocol?.executeAgainButtonTapped(indexPath: indexPath!)
    }
}
