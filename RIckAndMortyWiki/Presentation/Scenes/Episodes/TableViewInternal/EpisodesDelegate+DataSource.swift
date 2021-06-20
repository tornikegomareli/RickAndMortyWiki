//
//  Delegate+DataSource.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 17.06.21.
//

import Foundation
import UIKit

extension EpisodesViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.dataSource.value.count
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let model = viewModel.dataSource.value[indexPath.row]
    viewModel.didRequestOnRowClick(model: model)
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell")
      as! EpisodeCell
    
    let model = self.viewModel.dataSource.value[indexPath.row]
    cell.episodeNumberLabel.text = "\(indexPath.row + 1)"
    cell.configure(episode: model)
    if indexPath.row == viewModel.dataSource.value.count - 1 {
      if viewModel.dataSourceInfo.count > viewModel.dataSource.value.count {
        viewModel.fetchNextPage()
      }
    }
    return cell
  }
}

extension EpisodesViewController: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 130
  }
}

extension EpisodesViewController: UIScrollViewDelegate {
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard let headerView = tableView.tableHeaderView as? StretchyTableViewHeaderView else {
      return
    }
    
    headerView.scrollViewDidScroll(scrollView: tableView)
  }
}
