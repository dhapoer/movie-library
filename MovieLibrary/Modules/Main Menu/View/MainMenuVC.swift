//
//  MainMenuVC.swift
//  MovieLibrary
//
//  Created by abimanyu on 13/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Kingfisher

class MainMenuVC: UIViewController {
    
    private var networkStatus = Reach().connectionStatus()
    private var disposeBag = DisposeBag()
    private var container = UIView()
    private var noNetworkLabel = UILabel()
    private var tableView : UITableView = {
       var tableView = UITableView()
        tableView.register(SearchMovieCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for movies"
        return searchBar
    }()
    private var viewModel = MainMenuVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        setupConstraint()
        setupEvent()
        bindTableData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.rx.notification(NSNotification.Name(rawValue: ReachabilityStatusChangedNotification))
            .subscribe(onNext: { [weak self] value in
                self?.networkStatus = Reach().connectionStatus()
                self?.checkingNetwork()
            })
        .disposed(by: disposeBag)
        Reach().monitorReachabilityChanges()
    }
    
    func checkingNetwork(){
        switch networkStatus {
            case .offline:
                noNetworkView()
            case .online:
                networkNormalView()
            default:
                break
        }
    }
    
    func setupUI(){
        title = "Movie Library"
        view.addSubview(container)
        container.addSubview(searchBar)
        container.addSubview(tableView)
        view.backgroundColor = .systemGray
    }
    
    func setupConstraint(){
        container.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        searchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupEvent(){
        searchBar
            .rx.text
            .orEmpty
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] query in
                self.viewModel.keyword = (query == "" ? nil : query)
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoading.asDriver(onErrorJustReturn: true).drive(onNext:{ [unowned self] in
            if $0 {
                //self.showSpinner(onView: self.tableView)
            } else {
                //self.removeSpinner()
            }
        }).disposed(by: disposeBag)
    }
    
    func bindTableData(){
        
        //bind item to table
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: SearchMovieCell.self)) { row, item, cell in
            cell.bindData(item: item)
        }.disposed(by: disposeBag)
        
        //bind a model selected handler
        tableView.rx.modelSelected(SearchDetail.self).bind { item in
           let vc = MovieDetailVC(movieId: item.imdbID)
           self.navigationController?.pushViewController(vc, animated: true)
        }

        //fetch item
        viewModel.loadData()
    }
    
    func noNetworkView(){
        container.removeFromSuperview()
        view.addSubview(container)
        container.addSubview(noNetworkLabel)
        container.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        noNetworkLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        noNetworkLabel.text = "NO NETWORK"
    }
    
    func networkNormalView(){
        
        container.removeFromSuperview()
        view.addSubview(container)
        container.addSubview(searchBar)
        container.addSubview(tableView)
        
        container.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        searchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
