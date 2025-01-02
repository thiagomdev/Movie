import UIKit

final class MovieDetailView: UIView {
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .current)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .systemGreen
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var voteAverageLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .systemYellow
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) { nil }
}

extension MovieDetailView {
    func setup(
        imageURL: String,
        overview: String,
        releaseDate: String,
        voteAverage: String) {
        if let url = URL(
            string: "https://image.tmdb.org/t/p/w500\(imageURL).jpg") {
            overviewLabel.text = overview
            releaseDateLabel.text = releaseDate
            voteAverageLabel.text = voteAverage
            movieImageView.load(urlImage: url, mode: .scaleAspectFill)
        }
    }
    
    func setup(movie: MovieResult) {
        if let url = URL(
            string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "").jpg") {
            overviewLabel.text = movie.overview
            releaseDateLabel.text = movie.releaseDate ?? ""
            voteAverageLabel.text = "\(movie.voteAverage ?? 0.0)"
            movieImageView.load(urlImage: url, mode: .scaleAspectFill)
        }
    }
}

extension MovieDetailView: ViewConfiguration {
    func buildViews() {
        addSubview(overviewLabel)
        addSubview(movieImageView)
        addSubview(releaseDateLabel)
        addSubview(voteAverageLabel)
    }
    
    func pin() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            
            releaseDateLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 8),
            releaseDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            voteAverageLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 8),
            voteAverageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            overviewLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 8),
            overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func extraSetup() {
        backgroundColor = .systemBackground
    }
}
