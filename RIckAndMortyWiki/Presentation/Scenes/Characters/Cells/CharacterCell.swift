//
//  CharacterCell.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 19.06.21.
//

import UIKit
import Alamofire

class CharacterCell: UITableViewCell {
  @IBOutlet weak var cardView: UIView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var characterLivingStatusView: UIView!
  @IBOutlet weak var characterImageView: UIImageView!
  @IBOutlet weak var characterName: UILabel!
  @IBOutlet weak var characterLivingStatus: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  public func configure(model: MultipleCharacter) {
    activityIndicator.isHidden = false
    activityIndicator.startAnimating()
    AF.request( "\(model.image)",method: .get).response{ response in
       switch response.result {
        case .success(let responseData):
          self.activityIndicator.stopAnimating()
          self.activityIndicator.isHidden = true
          self.characterImageView.image = UIImage(data: responseData!, scale: 1)
        case .failure(let error):
          print("error--->",error)
        }
    }
    characterImageView.image = UIImage(named: model.image)
    characterName.text = model.name

    characterLivingStatus.text = model.status
    
    if model.status == "Alive" {
      characterLivingStatusView.backgroundColor = .green
    }else{
      characterLivingStatusView.backgroundColor = .red
    }
    
    characterLivingStatusView.layer.cornerRadius = characterLivingStatusView.layer.bounds.width / 2
    characterLivingStatusView.clipsToBounds = true
    characterLivingStatusView.layer.borderColor = UIColor.darkGray.cgColor
    characterLivingStatusView.layer.borderWidth = 2.0
    
    
    self.cardView.layer.cornerRadius = 20.0
    self.cardView.layer.shadowColor = UIColor.gray.cgColor
    self.cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.cardView.layer.shadowRadius = 7.0
    self.cardView.layer.shadowOpacity = 0.4
    
    self.characterImageView.layer.cornerRadius = 20.0
    self.characterImageView.layer.shadowColor = UIColor.gray.cgColor
    self.characterImageView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.characterImageView.layer.shadowRadius = 7.0
    self.characterImageView.layer.shadowOpacity = 0.4
  }
}
