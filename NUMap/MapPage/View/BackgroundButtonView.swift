
import UIKit

final class BackgroundButtonView: UIView {
    
    private enum Constants {
        static let backgroundColor: UIColor = .systemGray4
        static let cornerRadius: CGFloat = 20
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
        layer.cornerRadius = Constants.cornerRadius
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
