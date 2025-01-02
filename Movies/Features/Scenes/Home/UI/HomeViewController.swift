import UIKit

final class HomeViewController: UIViewController {
    private let homeView: HomeView
    private var viewModel: HomeViewModelProtocol
    
    weak var coodinator: HomeCoordinating?
    
    init(viewModel: HomeViewModelProtocol, homeView: HomeView) {
        self.viewModel = viewModel
        self.homeView = homeView
        super.init(nibName: nil, bundle: nil)
    }
  
    override func loadView() {
        super.loadView()
        view = homeView
        didSetTableViewProtocols()
        didFecthData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension HomeViewController {
    private func didFecthData() {
        Log.location(fileName: #file)
        viewModel.fetchData { [weak self] result in
            Log.queue(action: "Fetching JSON")
            switch result {
                case let .success(movies):
                Log.queue(action: "Fetching Image")
                self?.viewModel.movies.insert(movies.results)
                self?.reloadData()
            case let .failure(error):
                self?.showAlert(error.localizedDescription)
            }
        }
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Opa!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func didSetTableViewProtocols() {
        homeView.setting(delegate: self)
        homeView.setting(dataSource: self)
    }
    
    private func makeAnimation(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: tableView.bounds.size.height / 2).scaledBy(x: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.9, delay: .zero * Double(indexPath.row), usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseInOut, animations: {
            cell.transform = CGAffineTransform.identity
        })
    }
    
    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            Log.queue(action: "Updating UI")
            self?.homeView.reloadData()
            self?.loadViewIfNeeded()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let selectedMovie = viewModel.movies.first?[indexPath.row] {
            let receivedMovie: Set<MovieResult> = [selectedMovie]
            coodinator?.navigate(to: .detail(movie: receivedMovie))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.autoresizingMask.contains([.flexibleHeight, .flexibleWidth]) ? 150 : 220
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.first?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeCell.identifier,
            for: indexPath) as? HomeCell {

            configure(cell, at: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        makeAnimation(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    private func configure(_ cell: HomeCell, at indexPath: IndexPath) {
        if let selectedMovie = viewModel.movies.first?[indexPath.row] {
            cell.setupCell(with: .init(selectedMovie))
        }
    }
}
