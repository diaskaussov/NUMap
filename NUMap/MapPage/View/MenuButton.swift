
import UIKit

final class MenuButton: UIButton {
    
    private enum Constants {
        static let imageConfigPointSize: CGFloat = 24
        static let activeTintColor: UIColor =  .white
        static let inactiveTintColor: UIColor =  .black
        static let cornerRadius: CGFloat = 20
        static let activeBackgroundColor: UIColor = UIColor(
            red: 106.0/255.0,
            green: 95.0/255.0,
            blue: 255.0/255.0,
            alpha: 1
        )
        static let inactiveBackgroundColor: UIColor = .systemGray4
    }
    
    var isActive: Bool = false {
        didSet {
            updateAppearance(state: isActive)
        }
    }
    
    init(imageName: String) {
        super.init(frame: .zero)
        setImageForButton(name: imageName)
        setupButtonProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setImageForButton(name: String) {
        let imageConfig = UIImage.SymbolConfiguration(
            pointSize: Constants.imageConfigPointSize,
            weight: .bold
        )
        let image = UIImage(
            systemName: name,
            withConfiguration: imageConfig
        )
        setImage(
            image ?? UIImage(),
            for: .normal
        )
    }
    
    private func setupButtonProperties() {
        layer.cornerRadius = Constants.cornerRadius
        translatesAutoresizingMaskIntoConstraints = false
        updateAppearance(state: isActive)
    }
    
    func updateAppearance(state: Bool) {
        backgroundColor = state ? Constants.activeBackgroundColor : Constants.inactiveBackgroundColor
        tintColor = state ? Constants.activeTintColor : Constants.inactiveTintColor
    }
}

