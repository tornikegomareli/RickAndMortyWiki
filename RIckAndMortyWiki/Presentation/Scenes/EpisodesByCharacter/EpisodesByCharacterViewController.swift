//
//  EpisodesByCharacterViewController.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 20.06.21.
//  
//

import RxSwift

public class EpisodesByCharacterViewController: BaseViewController, Storyboarded {
  @IBOutlet weak var characterImageView: UIImageView!
  @IBOutlet weak var characterGender: UILabel!
  @IBOutlet weak var characterStatus: UILabel!
  @IBOutlet weak var tableView: UITableView!
  var episodeIds:[String] = [String]()
  
  public var viewModel: EpisodesByCharacterViewModel = DefaultEpisodesByCharacterViewModel()
  
  internal lazy var navigator = EpisodesByCharacterNavigator(viewController: self)
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    root: do {
     bind(to: viewModel)
     setup()
    }
    
    viewModel.viewDidLoad()
  }

  /// Bind to viewModel's observable properties
  private func bind(to viewModel: EpisodesByCharacterViewModel) {
    viewModel.dataSource.subscribe(onNext: { [weak self] dataSource in
      self?.didReceive(dataSource: dataSource)
    }).disposed(by: disposeBag)
    
    viewModel.action.subscribe(onNext: { [weak self] action in
      self?.didReceive(action: action)
    }).disposed(by: disposeBag)

    viewModel.route.subscribe(onNext: { [weak self] route in
      self?.didReceive(route: route)
    }).disposed(by: disposeBag)
  }

  /// Private user interface initializer
  private func setup() {
    fetchRequest()
    configureUIWithState()
    setupTableView()
    reloadTableView()
  }
  
  private func fetchRequest() {
    self.viewModel.didRequestFetchByCharacter(ids: episodeIds)
  }
  
  private func configureUIWithState() {
    
  }
  
  private func reloadTableView() {
    self.tableView.reloadData()
  }
  
  private func setupTableView() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(UINib(nibName: "EpisodeCell", bundle: nil), forCellReuseIdentifier: "EpisodeCell")
    self.tableView.separatorStyle = .none
  }
  
  private func didReceive(action: EpisodesByCharacterViewModelOutputAction){
    switch action {
      case .hideIndicator:
        stopIndicatingActivity()
      case .showIndicator:
        startIndicatingActivity()
    }
  }
  
  private func didReceive(dataSource: [Episode]) {
    reloadTableView()
  }
  
  private func didReceive(route: EpisodesByCharacterViewModelRoute) {
  }
  
  deinit {
    print("⬅️🗑 deinit EpisodesByCharacterViewController")
  }
}
