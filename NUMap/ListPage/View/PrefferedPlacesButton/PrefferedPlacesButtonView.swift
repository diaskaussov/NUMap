
import UIKit

final class PrefferedPlacesButtonView: UIView {
    private enum Constants {
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 1
        
        static let backgroundColor: UIColor = UIColor(
            red: 0.0/255.0,
            green: 0.0/255.0,
            blue: 0.0/255.0,
            alpha: 0.02
        )
        
        static let borderColor: CGColor = UIColor(
            red: 0.0/255.0,
            green: 0.0/255.0,
            blue: 0.0/255.0,
            alpha: 0.2
        ).cgColor
    }
    
    init() {
        super.init(frame: .zero)
        setupViewProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewProperties() {
        backgroundColor = Constants.backgroundColor
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = Constants.borderColor
        layer.cornerRadius = Constants.cornerRadius
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
