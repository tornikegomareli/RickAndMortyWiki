//
//  CharactersViewController.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 19.06.21.
//  
//

import RxSwift
import RxCocoa

public class CharactersViewController: BaseViewController, Storyboarded {
  @IBOutlet weak var arrowDown: UIButton!
  @IBOutlet weak var episodeTitle: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  public var episode:Episode!
  /// Main view model
  public var viewModel: CharactersViewModel = DefaultCharactersViewModel()

  /// Main Navigator  
  internal lazy var navigator = CharactersNavigator(viewController: self)
  

    // MARK: - Lifecycle methods
  public override func viewDidLoad() {
    super.viewDidLoad()
    let baseNavigationController = self.navigationController as! BaseNavigationController
    baseNavigationController.hideNavigationBar()
    root: do {
      bind(to: viewModel)
      setup()
      
      
    }
    
    viewModel.viewDidLoad(withParam: episode)
  }
  @IBAction func onDownArrowClick(_ sender: Any) {
    let transition:CATransition = CATransition()
    transition.duration = 0.5
    transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromBottom
    self.navigationController?.view.layer.add(transition, forKey: kCATransition)
    self.navigationController?.popViewController(animated: true)
  }
  
  /// Bind to viewModel's observable properties
  private func bind(to viewModel: CharactersViewModel) {
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
    configureUI()
    configureUIWithState()
    setupTableView()
    reloadTableView()
    searchBarThrottleSetup()
  }
  
  private func searchBarThrottleSetup() {
    searchBar
      .rx.text
      .orEmpty
      .debounce(DispatchTimeInterval.milliseconds(Int(0.5)), scheduler: MainScheduler.instance) // Wait 0.5 for changes.
        .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
      .subscribe(onNext: { [unowned self] query in
        if query.count == 0 {
          self.viewModel.dataSource.accept(self.viewModel.allCharactersData)
        }
        self.viewModel.dataSource.accept(self.viewModel.allCharactersData.filter{ $0.name.hasPrefix(query) })
      })
      .disposed(by: disposeBag)
  }
  
  private func configureUI() {
    searchBar.searchBarStyle = .minimal
  }
  
  private func configureUIWithState() {
    episodeTitle.text = episode.name
  }
  
  private func reloadTableView() {
    self.tableView.reloadData()
  }
  
  private func setupTableView() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
    self.tableView.separatorStyle = .none
  }

  /// Gets the viewModel action observable
  /// Subscribes to each observable
  private func didReceive(action: CharactersViewModelOutputAction){
    switch action {
      case .showIndicator:
        break
      case .hideIndicator:
        break
    }
  }

  private func didReceive(dataSource: [MultipleCharacter]) {
    reloadTableView()
  }
  
  private func didReceive(route: CharactersViewModelRoute) {
    navigator.requestNavigation(to: route, animated: true)
  }

  /// Invoked when deallocated
  deinit {
    print("?????????? deinit CharactersViewController")
  }
}
