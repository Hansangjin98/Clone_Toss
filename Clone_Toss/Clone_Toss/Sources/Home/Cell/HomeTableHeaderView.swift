//
//  HomeTableHeaderView.swift
//  Clone_Toss
//
//  Created by 한상진 on 2022/07/14.
//

import UIKit

final class HomeTableHeaderView: UIView {
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    private let arrowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "arrow.right")
        $0.tintColor = .black
    }
    
    init(frame: CGRect, cellType: CellType) {
        super.init(frame: frame)
        
        setupViews()
        setupLayouts()
        
        switch cellType {
        case .bank:
            titleLabel.text = "토스뱅크"
        case .assets:
            titleLabel.text = "자산"
        case .consumption:
            titleLabel.text = "소비"
            arrowImageView.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeTableHeaderView {
    func setupViews() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(arrowImageView)
    }
    
    func setupLayouts() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
}
