//
//  SearchMovieCell.swift
//  MovieLibrary
//
//  Created by abimanyu on 17/08/21.
//

import UIKit
import SnapKit
import Kingfisher

class SearchMovieCell: UITableViewCell {

    private lazy var titleLabel: UILabel = UILabel()
    private lazy var descriptionLabel: UILabel = UILabel()
    private lazy var imageBoxView: UIImageView = UIImageView()
    
    private func setupUI() -> Void {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(imageBoxView)
        
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 14)
        titleLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "Helvetica", size: 12)
        imageBoxView.contentMode = .scaleAspectFit
    }
    
    private func setupConstraint() -> Void {
        imageBoxView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.height.equalTo(40)
            $0.width.equalTo(30)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageBoxView.snp.trailing).offset(8)
            $0.top.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(imageBoxView.snp.trailing).offset(8)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.bottom.trailing.equalToSuperview().offset(-8)
        }
    }
    
    func bindData(item: SearchDetail) {
        titleLabel.text = item.title
        descriptionLabel.text = item.year
        let url = URL(string: item.poster)
        imageBoxView.kf.setImage(with: url)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}
