//
//  Delegate+Datasource.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 20.06.21.
//

import UIKit

extension EpisodesByCharacterViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.dataSource.value.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell")
      as! EpisodeCell
    
    let model = self.viewModel.dataSource.value[indexPath.row]
    
    cell.episodeNumberLabel.text = "\(indexPath.row + 1)"
    cell.configure(episode: model)
   

    return cell
  }
}

extension EpisodesByCharacterViewController: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let model = viewModel.dataSource.value[indexPath.row]
    viewModel.didRequestOnRowClick(model: model)
  }
}

