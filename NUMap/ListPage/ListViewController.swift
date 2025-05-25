
import UIKit

final class ListViewController: UIViewController {
    private enum Constants {
        static let blocksButtonTitle = "By Blocks"
        static let placesButtonTitle = "By Places"
    }
    
    private let blocksButton = PrefferedPlacesButton(name: Constants.blocksButtonTitle)
    private let placesButton = PrefferedPlacesButton(name: Constants.placesButtonTitle)
    
    override func viewDidLoad() {
        view.backgroundColor = .purple
        addSubviews()
        setupConstraints()
        configure()
    }
}

private extension ListViewController {
    private func addSubviews() {
//        view.addSubview(blocksButton)
//        view.addSubview(placesButton)
    }
    
    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            blocksButton.topAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutYAxisAnchor>#>)
//        ])
    }
    
    private func configure() {
        
    }
}
