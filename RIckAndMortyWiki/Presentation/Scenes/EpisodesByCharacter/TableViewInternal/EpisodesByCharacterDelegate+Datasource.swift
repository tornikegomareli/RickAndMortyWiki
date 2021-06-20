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
  
    cell.configure(episode: model)
    
    return cell
  }
}

extension EpisodesByCharacterViewController: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 300
  }
}

