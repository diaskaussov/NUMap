
import UIKit

final class SectionButton: UIButton {
    private enum Constants {
        static let chevronImageName = "chevron.right"
        static let chevronSize: CGFloat = 10
        static let chevronWeight: UIImage.SymbolWeight = .semibold
        
        static let expandedAngle: CGFloat = .pi / 2
        static let inexpandedAngle: CGFloat = 0
        
        static let titleFont: UIFont = .systemFont(ofSize: 18, weight: .medium)
        static let titleColor: UIColor = .black
        static let tintColor: UIColor = .black

        static let backgroundColor: UIColor = UIColor(
            red: 0 / 255,
            green: 0 / 255,
            blue: 0 / 255,
            alpha: 0.02
        )

        static let borderColor: CGColor = UIColor(
            red: 0 / 255,
            green: 0 / 255,
            blue: 0 / 255,
            alpha: 0.2
        ).cgColor

        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 8

        static let contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )
    }

    var isExpanded: Bool = false {
        didSet {
            rotateChevron(expanded: isExpanded)
        }
    }

    init(title: String, section: Int) {
        super.init(frame: .zero)
        configure(title: title, section: section)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - Setup SectionButton and Animation for Image

private extension SectionButton {
    private func configure(title: String, section: Int) {
        tag = section
        setTitle(title, for: .normal)
        setTitleColor(Constants.titleColor, for: .normal)
        backgroundColor = Constants.backgroundColor
        tintColor = Constants.tintColor
        titleLabel?.font = Constants.titleFont
        clipsToBounds = true
        contentHorizontalAlignment = .fill

        layer.borderWidth = Constants.borderWidth
        layer.borderColor = Constants.borderColor
        layer.cornerRadius = Constants.cornerRadius

        setupConfiguration()
    }

    private func setupConfiguration() {
        var config = UIButton.Configuration.plain()
        config.titleAlignment = .leading
        config.contentInsets = Constants.contentInsets
        config.imagePlacement = .trailing
        config.image = makeChevronImage()
        configuration = config
    }

    private func makeChevronImage() -> UIImage? {
        let config = UIImage.SymbolConfiguration(
            pointSize: Constants.chevronSize,
            weight: Constants.chevronWeight
        )
        return UIImage(systemName: Constants.chevronImageName, withConfiguration: config)
    }

    private func rotateChevron(expanded: Bool) {
        let angle: CGFloat = expanded ? Constants.expandedAngle : Constants.inexpandedAngle
        UIView.animate(withDuration: 0.25) {
            self.imageView?.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
}
