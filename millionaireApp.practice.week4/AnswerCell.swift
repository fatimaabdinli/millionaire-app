//
//  AnswerCell.swift
//  millionaireApp.practice.week4
//
//  Created by Fatima Abdinli on 23.12.23.
//

import UIKit

class AnswerCell: UITableViewCell {
    @IBOutlet weak var answerLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
