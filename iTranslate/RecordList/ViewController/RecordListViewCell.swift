//
//  RecordListViewCell.swift
//  iTranslate
//
//  Created by Sajeev on 3/8/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import UIKit

class RecordListViewCell: UITableViewCell {

    @IBOutlet weak var durationLabel: UILabel?
    @IBOutlet weak var nameLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureView(record: RecordDisplayViewModel) {
        nameLabel?.text = record.name
        durationLabel?.text = record.duration
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
