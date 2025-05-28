
import UIKit

final class CustomTableViewCell: UITableViewCell {
    private enum Constants {
        static let cornerRadius: CGFloat = 10
        static let textColor: UIColor = .black
        static let textFont: UIFont = .systemFont(ofSize: 16, weight: .light)
        static let backgroundColor: UIColor = .white
        static let separatorColor: UIColor = UIColor(
            red: 0 / 255,
            green: 0 / 255,
            blue: 0 / 255,
            alpha: 0.5
        )
    }
    
    enum CellPosition {
        case lastRow
        case notLastRow
    }
    
    static let identifier = "CustomTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.textColor
        label.font = Constants.textFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.separatorColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, position: CellPosition) {
        titleLabel.text = title
        setSeparator(position: position)
    }
}

//MARK: - Setup Cell and Layout

private extension CustomTableViewCell {
    private func setupCell() {
        self.clipsToBounds = true
        self.selectionStyle = .none
        configureBackground()
    }
    
    private func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(separator)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setSeparator(position: CellPosition) {
        switch position {
        case .lastRow:
            separator.isHidden = true
        case .notLastRow:
            separator.isHidden = false
        }
    }
    
    private func configureBackground() {
        var backgroundConfig = UIBackgroundConfiguration.listCell()
        backgroundConfig.backgroundColor = Constants.backgroundColor
        backgroundConfig.cornerRadius = Constants.cornerRadius
        self.backgroundConfiguration = backgroundConfig
    }
}
