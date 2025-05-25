
import UIKit

final class PrefferedPlacesButton: UIButton {
    
    init(name: String) {
        super.init(frame: .zero)
        setupButtonProperties(title: name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonProperties(title: String) {
        setTitle(title, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
