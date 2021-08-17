//
//  MovieDetailVC.swift
//  MovieLibrary
//
//  Created by abimanyu on 13/08/21.
//


import UIKit
import RxSwift
import RxCocoa
import SnapKit
import ShimmerSwift

class MovieDetailVC: UIViewController {
    
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var descriptionLabel: UILabel = UILabel()
    private lazy var imageBoxView: UIImageView = UIImageView()
    
    private var viewModel = MovieDetailVM()
    private var disposeBag = DisposeBag()

    init(movieId: String) {
        super.init(nibName: nil, bundle: nil)
        setupUI()
        setupConstraint()
        setupEvent()
        viewModel.movieId = movieId
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    func setupUI(){
        title = "Movie Detail"
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(imageBoxView)
        view.backgroundColor = .white
        
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 14)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        descriptionLabel.font = UIFont(name: "Helvetica-Light", size: 12)
        descriptionLabel.textAlignment = .center
        imageBoxView.contentMode = .scaleAspectFill
    }
    
    func setupConstraint(){
        imageBoxView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(200)
            $0.width.equalTo(150)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageBoxView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.bottom.lessThanOrEqualToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
    
    func setupEvent(){
        viewModel.isLoading.asDriver(onErrorJustReturn: true).drive(onNext:{ [unowned self] in
            if $0 {
                self.showSpinner(onView: self.view)
            } else {
                self.removeSpinner()
            }
        }).disposed(by: disposeBag)
        viewModel.items.asDriver(onErrorJustReturn: nil).drive(onNext:{ [weak self] in
            if let data = $0 {
                self?.titleLabel.text = data.title
                self?.descriptionLabel.text = data.year
                let url = URL(string: data.poster)
                self?.imageBoxView.kf.setImage(with: url)
            }
        }).disposed(by: disposeBag)

    }
}
