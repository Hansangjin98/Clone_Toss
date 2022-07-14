//
//  ViewController.swift
//  Clone_Toss
//
//  Created by 한상진 on 2022/07/14.
//

import UIKit

final class HomeViewController: UIViewController {
    private let topView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(systemName: "dollarsign.circle")
        $0.tintColor = .darkGray
    }
    
    private let logoLabel = UILabel().then {
        $0.text = "toss"
        $0.textColor = .systemGray
        $0.font = .systemFont(ofSize: 30, weight: .bold)
    }

    private let chatImageView = UIImageView().then {
        $0.image = UIImage(systemName: "message.fill")
        $0.tintColor = .systemGray
    }
    
    private let notiImageView = UIImageView().then {
        $0.image = UIImage(systemName: "bell.fill")
        $0.tintColor = .systemGray
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
}
 
private extension HomeViewController {
    func setupViews() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(topView)
        topView.addSubview(logoImageView)
        topView.addSubview(logoLabel)
        topView.addSubview(chatImageView)
        topView.addSubview(notiImageView)
    }
    
    func setupLayouts() {
        topView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        logoImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-15)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(30)
        }
        
        logoLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(10)
            $0.bottom.equalToSuperview().offset(-13)
        }
        
        chatImageView.snp.makeConstraints {
            $0.trailing.equalTo(notiImageView.snp.leading).offset(-20)
            $0.bottom.equalTo(logoImageView.snp.bottom)
            $0.width.height.equalTo(25)
        }
        
        notiImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(logoImageView.snp.bottom)
            $0.width.height.equalTo(25)
        }
    }
}

