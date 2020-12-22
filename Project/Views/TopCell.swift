//
//  TopCell.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import UIKit

class TopCell: UITableViewCell {

    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var type: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bind(_ viewModel: TopCellViewModel?) {
        guard let viewModel = viewModel else { return }
        
        topImage.setImage(with: URL(string: viewModel.imageUrl))
        title.text = viewModel.title
        rank.text = String(viewModel.rank)
        startDate.text = "Start Date: \(viewModel.startDate ?? "")"
        endDate.text = "End Date: \(viewModel.endDate ?? "")"
        type.text = viewModel.type
    }
}
