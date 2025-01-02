import UIKit

final class HomeCell: UITableViewCell {
    static var identifier: String { String(describing: self) }
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.shadowColor = UIColor.darkGray.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 7.0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieOverViewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(with movie: HomeCellViewModel) {
        movieTitleLabel.text = movie.title
        movieOverViewLabel.text = movie.overview
        didDownloadImage(movie.imgURL)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        movieTitleLabel.text = nil
        movieOverViewLabel.text = nil
    }
}

extension HomeCell {
    private func didDownloadImage(_ url: String) {
        if let url = URL(
            string: "https://image.tmdb.org/t/p/w500\(url).jpg") {
            movieImageView.load(urlImage: url, mode: .scaleAspectFit)
            layoutIfNeeded()
        }
    }
}

extension HomeCell: ViewConfiguration {
    func buildViews() {
        contentView.addSubViews(
            movieImageView,
            movieTitleLabel,
            movieOverViewLabel
        )
    }
    
    func pin() {
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            movieImageView.heightAnchor.constraint(equalToConstant: 180),
            movieImageView.widthAnchor.constraint(equalToConstant: 130),
            
            movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.firstBaselineAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            movieOverViewLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor),
            movieOverViewLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            movieOverViewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            movieOverViewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func extraSetup() {
        selectionStyle = .none
    }
}

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
