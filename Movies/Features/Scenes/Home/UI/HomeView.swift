import UIKit

protocol HomeViewProtocol {
    func setting(delegate: UITableViewDelegate)
    func setting(dataSource: UITableViewDataSource)
    func reloadData()
}

final class HomeView: UIView {
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(HomeCell.self, forCellReuseIdentifier: HomeCell.identifier)
        table.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private(set) lazy var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .large)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.color = .systemGreen
        return loading
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        tableView.frame = bounds
    }
    
    required init?(coder: NSCoder) { nil }
}

extension HomeView: HomeViewProtocol {
    func setting(delegate: UITableViewDelegate) {
        tableView.delegate = delegate
    }
    
    func setting(dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension HomeView: ViewConfiguration {
    func buildViews() {
        addSubview(tableView)
        addSubview(loading)
    }
    
    func pin() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            loading.centerXAnchor.constraint(equalTo: centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func extraSetup() {
        backgroundColor = .systemBackground
    }
}

