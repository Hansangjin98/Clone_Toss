//
//  ViewController.swift
//  Clone_Toss
//
//  Created by 한상진 on 2022/07/14.
//

import UIKit
import RxSwift
import RxCocoa

enum ScrollDirection {
    case UP
    case DOWN
}

final class HomeViewController: UIViewController, UIScrollViewDelegate {
    private let bankData = [
        HomeTableViewModel(iconImage: UIImage(named: "토스")!, titleText: "모두에게 드려요", subTitleText: "5,000원을 받아가세요")
    ]
    
    private let assetsData = [
        HomeTableViewModel(iconImage: UIImage(named: "국민은행")!, titleText: "KB나라사랑우대통장", subTitleText: "1,123,456 원"),
        HomeTableViewModel(iconImage: UIImage(named: "카카오뱅크")!, titleText: "입출금통장", subTitleText: "789,123 원"),
        HomeTableViewModel(iconImage: UIImage(named: "신한은행")!, titleText: "네이버페이 라인프렌즈 신한카드", subTitleText: "500,123 원"),
        HomeTableViewModel(iconImage: UIImage(named: "농협")!, titleText: "농협장기적금", subTitleText: "30,000,000 원"),
        HomeTableViewModel(iconImage: UIImage(named: "포인트")!, titleText: "포인트·머니·5개", subTitleText: "8,766 원")
    ]
    
    private let consumptionData = [
        HomeTableViewModel(iconImage: UIImage(named: "라인프렌즈")!, titleText: "이번 달 쓴 금액", subTitleText: "350,000 원"),
        HomeTableViewModel(iconImage: UIImage(named: "달력")!, titleText: "8월 1일 낼 카드값", subTitleText: "585,750 원")
    ]
    
    private lazy var disposeBag = DisposeBag()
    private var scrollDirection: ScrollDirection?
    private lazy var lastContentOffset: CGFloat = 0
    
    private lazy var bottomView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.isHidden = true
    }
    private lazy var bottomLine = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.isHidden = true
    }
    private lazy var bottomLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.text = "소비"
    }
    
    private let topView = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.alpha = 0.97
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
    
    private let scrollView = UIScrollView().then {
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    private let contentView = UIView()
    
    private let bankTableView = UITableView().then {
        $0.layer.cornerRadius = 20
        $0.separatorStyle = .none
        $0.rowHeight = 60
        $0.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = 0
        }
    }
    
    private let assetsTableView = UITableView().then {
        $0.layer.cornerRadius = 20
        $0.separatorStyle = .none
        $0.rowHeight = 60
        $0.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = 0
        }
    }
    
    private let consumptionTableView = UITableView().then {
        $0.layer.cornerRadius = 20
        $0.separatorStyle = .none
        $0.rowHeight = 60
        $0.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = 0
        }
    }
    
    private let bankTableHeaderView = HomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: 355, height: 60), cellType: .bank)
    private let assetsTableHeaderView = HomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: 355, height: 60), cellType: .assets)
    private let consumptionTableHeaderView = HomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: 355, height: 60), cellType: .consumption)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        setupBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initConsumptionView()
    }
}

private extension HomeViewController {
    func setupViews() {
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        view.addSubview(topView)
        topView.addSubview(logoImageView)
        topView.addSubview(logoLabel)
        topView.addSubview(chatImageView)
        topView.addSubview(notiImageView)
        
        contentView.addSubview(assetsTableView)
        contentView.addSubview(bankTableView)
        contentView.addSubview(consumptionTableView)
        
        view.addSubview(bottomView)
        bottomView.addSubview(bottomLabel)
        bottomView.addSubview(bottomLine)
    }
    
    func setupLayouts() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        
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
        
        bankTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(110)
            $0.height.equalTo(140)
        }
        
        assetsTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(bankTableView.snp.bottom).offset(20)
            $0.height.equalTo(410)
        }
        
        consumptionTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(assetsTableView.snp.bottom).offset(20)
            $0.height.equalTo(190)
            $0.bottom.equalToSuperview().offset(-100)
        }
        
        bottomView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(660)
            $0.height.equalTo(70)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        bottomLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(18)
        }
        
        bottomLine.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.top.equalTo(bottomLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func setupBinding() {
        scrollView.delegate = self
        bankTableView.rx.setDelegate(self).disposed(by: disposeBag)
        assetsTableView.rx.setDelegate(self).disposed(by: disposeBag)
        consumptionTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        Observable.of(bankData)
            .bind(to: bankTableView.rx.items) { _, row, item -> UITableViewCell in
                guard let cell = self.bankTableView.dequeueReusableCell(
                    withIdentifier: "HomeTableViewCell",
                    for: IndexPath(row: row, section: 0)
                ) as? HomeTableViewCell else { return UITableViewCell() }
                cell.configure(
                    image: item.iconImage,
                    title: item.titleText,
                    amount: item.subTitleText,
                    cellType: .bank
                )
                return cell
            }
            .disposed(by: disposeBag)
        
        Observable.of(assetsData)
            .bind(to: assetsTableView.rx.items) { _, row, item -> UITableViewCell in
                guard let cell = self.assetsTableView.dequeueReusableCell(
                    withIdentifier: "HomeTableViewCell",
                    for: IndexPath(row: row, section: 0)
                ) as? HomeTableViewCell else { return UITableViewCell() }
                cell.configure(
                    image: item.iconImage,
                    title: item.titleText,
                    amount: item.subTitleText,
                    cellType: .assets
                )
                
                if row == 4 {
                    let lineView = UIView().then { $0.backgroundColor = .systemGray }
                    cell.addSubview(lineView)
                    lineView.snp.makeConstraints {
                        $0.top.equalToSuperview().offset(10)
                        $0.height.equalTo(0.2)
                        $0.leading.trailing.equalToSuperview().inset(18)
                    }
                    cell.setupAssetsLayout()
                }
                
                return cell
            }
            .disposed(by: disposeBag)
        
        Observable.of(consumptionData)
            .bind(to: consumptionTableView.rx.items) { _, row, item -> UITableViewCell in
                guard let cell = self.consumptionTableView.dequeueReusableCell(
                    withIdentifier: "HomeTableViewCell",
                    for: IndexPath(row: row, section: 0)
                ) as? HomeTableViewCell else { return UITableViewCell() }
                
                cell.configure(
                    image: item.iconImage,
                    title: item.titleText,
                    amount: item.subTitleText,
                    cellType: .consumption
                )
                
                if row == 1 { cell.featureButton.isHidden = true }
                return cell
            }
            .disposed(by: disposeBag)
        
        scrollView.rx.didScroll
            .bind { [weak self] in
                guard let self = self else { return }
                let scrollY = self.scrollView.contentOffset.y
                if self.lastContentOffset > scrollY {
                    if self.scrollDirection == .DOWN { self.scrollDirection = .UP}
                    if self.scrollDirection == .UP && scrollY < 40 {
                        self.consumptionBarUp()
                    }
                } else if self.lastContentOffset < scrollY {
                    if self.scrollDirection == .UP { self.scrollDirection = .DOWN}
                    if self.scrollDirection == .DOWN && scrollY > 40 {
                        self.consumptionBarDown()
                    }
                }
                
                self.lastContentOffset = scrollY
            }
            .disposed(by: disposeBag)
    }
    
    func initConsumptionView() {
        if bottomView.frame.origin.y > 600 {
            scrollDirection = .UP
            consumptionTableView.snp.updateConstraints {
                $0.leading.trailing.equalToSuperview()
            }
            bottomView.snp.updateConstraints {
                $0.leading.trailing.equalToSuperview()
            }
            bottomLine.snp.updateConstraints {
                $0.leading.trailing.equalToSuperview().inset(40)
            }
            bottomLabel.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(40)
            }
            bottomView.isHidden = false
            bottomLine.isHidden = false
            tabBarController?.tabBar.layer.borderWidth = 0
            tabBarController?.tabBar.layer.cornerRadius = 0
        } else {
            scrollDirection = .DOWN
            bottomLine.isHidden = true
            bottomView.isHidden = true
        }
        
        bottomView.layer.cornerRadius = 20
    }
    
    func consumptionBarDown() {
        bottomLine.isHidden = true
        bottomView.layer.borderWidth = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.consumptionTableView.snp.updateConstraints {
                $0.leading.trailing.equalToSuperview().inset(20)
            }
            self.bottomView.snp.remakeConstraints {
                $0.top.equalTo(self.consumptionTableView)
                $0.height.equalTo(70)
                $0.leading.trailing.equalToSuperview().inset(20)
            }
            self.bottomLine.snp.updateConstraints {
                $0.leading.trailing.equalToSuperview().inset(20)
            }
            self.bottomLabel.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(20)
            }
            self.consumptionTableView.layoutIfNeeded()
            self.bottomView.layoutIfNeeded()
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.bottomView.isHidden = true
            }
            self.tabBarController?.tabBar.layer.borderWidth = 0.3
            self.tabBarController?.tabBar.layer.cornerRadius = 20
        })
    }
    func consumptionBarUp() {
        tabBarController?.tabBar.layer.borderWidth = 0
        tabBarController?.tabBar.layer.cornerRadius = 0
        bottomView.layer.borderWidth = 0.3
        bottomLine.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.consumptionTableView.snp.updateConstraints {
                $0.leading.trailing.equalToSuperview()
            }
            self.bottomView.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(660)
                $0.height.equalTo(70)
                $0.leading.trailing.equalToSuperview()
            }
            self.bottomLine.snp.updateConstraints {
                $0.leading.trailing.equalToSuperview().inset(40)
            }
            self.bottomLabel.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(40)
            }
            self.bottomView.layoutIfNeeded()
            self.consumptionTableView.layoutIfNeeded()
        }, completion: { _ in
            self.bottomView.isHidden = false
        })
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch tableView {
        case bankTableView: return bankTableHeaderView
        case assetsTableView: return assetsTableHeaderView
        case consumptionTableView: return consumptionTableHeaderView
        default: return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
