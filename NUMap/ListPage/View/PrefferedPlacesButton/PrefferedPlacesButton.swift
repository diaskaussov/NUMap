
import UIKit

final class PrefferedPlacesButton: UIButton {
    private enum Constants {
        static let cornerRadius: CGFloat = 10
        static let activeTextColor: UIColor =  .white
        static let inactiveTextColor: UIColor =  .black
        static let activeBackgroundColor: UIColor = UIColor(
            red: 106.0/255.0,
            green: 95.0/255.0,
            blue: 255.0/255.0,
            alpha: 1
        )
        static let inactiveBackgroundColor: UIColor = UIColor(
            red: 0.0/255.0,
            green: 0.0/255.0,
            blue: 0.0/255.0,
            alpha: 0.02
        )
    }
    
    var isActive: Bool = false {
        didSet {
            updateAppearance(state: isActive)
        }
    }
    
    init(name: String) {
        super.init(frame: .zero)
        setupButtonProperties(title: name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonProperties(title: String) {
        setTitle(title, for: .normal)
        layer.cornerRadius = Constants.cornerRadius
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func updateAppearance(state: Bool) {
        backgroundColor = state ? Constants.activeBackgroundColor : Constants.inactiveBackgroundColor
        setTitleColor(
            state ? Constants.activeTextColor : Constants.inactiveTextColor,
            for: .normal
        )
    }
}
