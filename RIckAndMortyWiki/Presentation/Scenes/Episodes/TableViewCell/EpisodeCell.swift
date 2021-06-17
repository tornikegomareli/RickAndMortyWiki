//
//  EpisodeCell.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 17.06.21.
//

import UIKit

class EpisodeCell: UITableViewCell {
  @IBOutlet weak var charactersCountButton: UIButton!
  @IBOutlet weak var episodeNumberLabel: UILabel!
  @IBOutlet weak var airDateLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var episodeLabel: UILabel!
  @IBOutlet weak var counterBackgroundView: UIView!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
 
  func configure(episode: Episode) {
    charactersCountButton.setTitle("\(episode.characters.count) Characters", for: .normal)
    airDateLabel.text = episode.airDate
    nameLabel.text = episode.name
    episodeLabel.text = episode.episode
    counterBackgroundView.layer.cornerRadius = counterBackgroundView.layer.bounds.width / 2
    counterBackgroundView.clipsToBounds = true
    counterBackgroundView.layer.borderColor = UIColor.darkGray.cgColor
    counterBackgroundView.layer.borderWidth = 2.0
  }
}
