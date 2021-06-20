//
//  EpisodesByCharacterViewController.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 20.06.21.
//  
//

import RxSwift
import Alamofire

public class EpisodesByCharacterViewController: BaseViewController, Storyboarded {
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var characterImageView: UIImageView!
  @IBOutlet weak var characterGender: UILabel!
  @IBOutlet weak var characterStatus: UILabel!
  @IBOutlet weak var tableView: UITableView!
  var character:MultipleCharacter!
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
    searchBarThrottleSetup()
  }
  
  @IBAction func downArrayClick(_ sender: Any) {
    let transition:CATransition = CATransition()
    transition.duration = 0.5
    transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromBottom
    self.navigationController?.view.layer.add(transition, forKey: kCATransition)
    self.navigationController?.popViewController(animated: true)
  }
  
  private func fetchRequest() {
    episodeIds = character.episode
    self.viewModel.didRequestFetchByCharacter(ids: episodeIds)
  }
  
  private func configureUIWithState() {
    startIndicatingActivity()
    AF.request( "\(character.image)",method: .get).response{ response in
       switch response.result {
        case .success(let responseData):
          self.stopIndicatingActivity()
          self.characterImageView.image = UIImage(data: responseData!, scale: 1)
        case .failure(let error):
          print("error--->",error)
        }
    }
    
    characterStatus.text = character.status
    characterGender.text = character.gender
  }
  
  private func reloadTableView() {
    self.tableView.reloadData()
  }
  
  private func searchBarThrottleSetup() {
    searchBar
      .rx.text
      .orEmpty
      .debounce(DispatchTimeInterval.milliseconds(Int(0.5)), scheduler: MainScheduler.instance)
        .distinctUntilChanged()
      .subscribe(onNext: { [unowned self] query in
        if query.count == 0 {
          self.viewModel.dataSource.accept(self.viewModel.allEpisodesData)
        }
        self.viewModel.dataSource.accept(self.viewModel.allEpisodesData.filter{ $0.name.hasPrefix(query) })
      })
      .disposed(by: disposeBag)
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
    navigator.requestNavigation(to: route, animated: true)
  }
  
  deinit {
    print("⬅️🗑 deinit EpisodesByCharacterViewController")
  }
}
