
import UIKit

class LocationButton: UIButton {
    private enum Constants {
        static let imageConfigPointSize: CGFloat = 24
        static let locationImageName: String = "location.north"
        static let tintColor: UIColor =  .white
        static let cornerRadius: CGFloat = 45
        static let backgroundColor: UIColor = UIColor(
            red: 106.0/255.0,
            green: 95.0/255.0,
            blue: 255.0/255.0,
            alpha: 1
        )
    }
    
    init() {
        super.init(frame: .zero)
        setImageForButton()
        setupButtonProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setImageForButton() {
        let imageConfig = UIImage.SymbolConfiguration(
            pointSize: Constants.imageConfigPointSize,
            weight: .bold
        )
        let image = UIImage(
            systemName: Constants.locationImageName,
            withConfiguration: imageConfig
        )
        setImage(
            image ?? UIImage(),
            for: .normal
        )
    }
    
    private func setupButtonProperties() {
        tintColor = Constants.tintColor
        backgroundColor = Constants.backgroundColor
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
}
