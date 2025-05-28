
import UIKit

final class SearchCancelButton: UIButton {
    private enum Constants {
        static let imageConfigPointSize: CGFloat = 18
        static let tintColor: UIColor = UIColor(
            red: 103.0/255.0,
            green: 102.0/255.0,
            blue: 102.0/255.0,
            alpha: 1.0
        )
    }
    
    init(name: String) {
        super.init(frame: .zero)
        configure(with: name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(with name: String) {
        let config = UIImage.SymbolConfiguration(
            pointSize: Constants.imageConfigPointSize,
            weight: .bold
        )
        let image = UIImage(systemName: name, withConfiguration: config)
        setImage(
            image ?? UIImage(),
            for: .normal
        )
        setupButtonProperties()
    }
    
    private func setupButtonProperties() {
        tintColor = Constants.tintColor
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        imageView?.contentMode = .scaleAspectFill
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
