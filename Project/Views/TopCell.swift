//
//  TopCell.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import UIKit
import RxSwift

class TopCell: UITableViewCell {

    private var viewModel: TopCellViewModel?
    private let bag: DisposeBag = .init()

    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

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
        self.viewModel = viewModel
        topImage.setImage(with: URL(string: viewModel.imageUrl))
        title.text = viewModel.title
        rank.text = String(viewModel.rank)
        startDate.text = "Start Date: \(viewModel.startDate ?? "")"
        endDate.text = "End Date: \(viewModel.endDate ?? "")"
        type.text = viewModel.type
        self.bindRx(vm: viewModel)
    }

    private func bindRx(vm: TopCellViewModel) {
        vm.favoriteState
            .subscribe (onNext: { [weak self] state in
                switch state {
                case .like:
                    self?.favoriteButton.setImage(UIImage(named: "icon_home_like_after40x40"), for: .normal)
                case .unlike:
                    self?.favoriteButton.setImage(UIImage(named: "icon_home_like_before40x40"), for: .normal)
                }
            })
            .disposed(by: bag)
    }

    @IBAction func favoriteButtnPressed(_ sender: Any) {
        self.viewModel?.toggleFavoriteButton()
    }
    
}
