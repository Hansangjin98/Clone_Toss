//
//  HomeTableViewCell.swift
//  Clone_Toss
//
//  Created by 한상진 on 2022/07/14.
//

import UIKit

enum CellType {
    case bank
    case assets
    case consumption
}

class HomeTableViewCell: UITableViewCell {
    private let iconImageView = UIImageView()
    
    private let titleLable = UILabel().then {
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 14)
    }
    
    private let amountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    let featureButton = UIButton().then {
        $0.backgroundColor = .systemGray6
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        $0.layer.cornerRadius = 5
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(image: UIImage, title: String, amount: String, cellType: CellType) {
        iconImageView.image = image
        titleLable.text = title
        amountLabel.text = amount
        
        switch cellType {
        case .bank:
            featureButton.isHidden = true
        case .assets:
            featureButton.isHidden = false
            featureButton.setTitle("송금", for: .normal)
        case .consumption:
            featureButton.isHidden = false
            featureButton.setTitle("내역", for: .normal)
        }
    }
    
    func setupAssetsLayout() {
        iconImageView.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(40)
            $0.top.equalToSuperview().offset(40)
        }
        
        featureButton.snp.remakeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(40)
            $0.width.equalTo(45)
            $0.height.equalTo(30)
        }
    }
}

private extension HomeTableViewCell {
    func setupViews() {
        backgroundColor = .white
        selectionStyle = .none
        
        addSubview(iconImageView)
        addSubview(titleLable)
        addSubview(amountLabel)
        addSubview(featureButton)
    }
    
    
    func setupLayouts() {
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(40)
            $0.centerY.equalToSuperview()
        }
        
        titleLable.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.top).offset(-1)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
        }
        
        amountLabel.snp.makeConstraints {
            $0.bottom.equalTo(iconImageView.snp.bottom).offset(1)
            $0.leading.equalTo(titleLable.snp.leading)
        }
        
        featureButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(45)
            $0.height.equalTo(30)
        }
    }
}
