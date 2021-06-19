//
//  EpisodesViewController.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 17.06.21.
//  
//

import RxSwift

public class EpisodesViewController: BaseViewController, Storyboarded {
  @IBOutlet weak var tableView: UITableView!
  
  lazy var headerView: StretchyTableViewHeaderView = {
    var header = StretchyTableViewHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height / 1.8))
    header.imageView.makeRounded()
    header.imageView.image = UIImage(named: "mainPicRick")
    return header
  }()
  
  public var viewModel: DefaultEpisodesViewModel = DefaultEpisodesViewModel()
  internal lazy var navigator = EpisodesNavigator(viewController: self)

    // MARK: - Lifecycle methods
  public override func viewDidLoad() {
    super.viewDidLoad()
    var baseNavigationController = self.navigationController as! BaseNavigationController
    baseNavigationController.hideNavigationBar()
    root: do {
      bind(to: viewModel)
      setup()
      
    }
    
    viewModel.viewDidLoad()
  }
  
  public override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }

  /// Bind to viewModel's observable properties
  private func bind(to viewModel: EpisodesViewModel) {
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
    setupTableView()
    setupHeaderOnTableView()
    reloadTableView()
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
  
  private func setupHeaderOnTableView() {
    tableView.tableHeaderView = headerView
  }
  
  private func didReceive(dataSource: [Episode]) {
    reloadTableView()
  }
  
  private func didReceive(action: EpisodesViewModelOutputAction){
    switch action {
      case .hideIndicator:
        stopIndicatingActivity()
      case .showIndicator:
        startIndicatingActivity()
    }
  }

  /// Gets the viewModel route observable
  /// Subscribes to each observable
  /// Then function uses Navigator, to navigate correct destination
  private func didReceive(route: EpisodesViewModelRoute) {
    navigator.requestNavigation(to: route, animated: true)
  }

  /// Invoked when deallocated
  deinit {
    print("⬅️🗑 deinit EpisodesViewController")
  }
}
