//
//  TableViewCell.swift
//  SwiftProject
//
//  Created by Emma Houlé on 30/01/2016.
//  Copyright © 2016 etu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    // MARK: - Attributs
    
    /// Déclaration des labels qui contiendront les données
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellABikeStands: UILabel!
    @IBOutlet weak var cellABikes: UILabel!
    
    
    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
