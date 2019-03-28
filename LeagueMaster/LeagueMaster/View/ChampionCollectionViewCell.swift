//
//  ChampionCollectionViewCell.swift
//  LeagueMaster
//
//  Created by Ying Yang on 3/27/19.
//  Copyright © 2019 Ying Yang. All rights reserved.
//

import UIKit
import SDWebImage

class ChampionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(champion: Champion){
        self.nameLabel.text = champion.name
        self.imageView.sd_setImage(with: URL(string: "\(STATIC_DATA_BASE_URL)/cdn/img/champion/loading/\(champion.id)_0.jpg"), placeholderImage: UIImage(named: "Aatrox"))
    }

}
