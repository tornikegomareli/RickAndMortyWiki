//
//  Delegate+Datasource.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 19.06.21.
//

import UIKit

extension CharactersViewController: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 300
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let model = self.viewModel.dataSource.value[indexPath.row]
    self.viewModel.didRequestNavigationToEpisodesByCharacter(model: model)
  }
}

extension CharactersViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.dataSource.value.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell")
      as! CharacterCell
    
    let model = viewModel.dataSource.value[indexPath.row]
    cell.configure(model: model)
    return cell
  }
}


