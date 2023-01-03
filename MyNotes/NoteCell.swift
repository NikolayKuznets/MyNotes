//
//  NoteCell.swift
//  MyNotes
//
//  Created by Ник К on 25.12.2022.
//

import UIKit

class NoteCell: UITableViewCell {
    static let cellId = "NoteCell"
    static let height: CGFloat = 84
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
