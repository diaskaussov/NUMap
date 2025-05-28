
import UIKit

final class MenuButton: UIButton {
    private enum Constants {
        static let imageConfigPointSize: CGFloat = 24
        static let cornerRadius: CGFloat = 20
        static let activeTintColor: UIColor =  .white
        static let inactiveTintColor: UIColor =  .black
        
        static let activeBackgroundColor: UIColor = UIColor(
            red: 106.0/255.0,
            green: 95.0/255.0,
            blue: 255.0/255.0,
            alpha: 1
        )
        
        static let inactiveBackgroundColor: UIColor = UIColor(
            red: 228.0/255.0,
            green: 228.0/255.0,
            blue: 228.0/255.0,
            alpha: 1
        )
    }
    
    var isActive: Bool = false {
        didSet {
            updateAppearance(state: isActive)
        }
    }
    
    init(imageName: String) {
        super.init(frame: .zero)
        configure(with: imageName)
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
        layer.cornerRadius = Constants.cornerRadius
        translatesAutoresizingMaskIntoConstraints = false
        updateAppearance(state: isActive)
    }
    
    private func updateAppearance(state: Bool) {
        backgroundColor = state ? Constants.activeBackgroundColor : Constants.inactiveBackgroundColor
        tintColor = state ? Constants.activeTintColor : Constants.inactiveTintColor
    }
}
