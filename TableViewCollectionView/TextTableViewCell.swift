//
//  TextTableViewCell.swift
//  TableViewCollectionView
//
//  Created by 蔡尚諺 on 2022/1/14.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var testTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
