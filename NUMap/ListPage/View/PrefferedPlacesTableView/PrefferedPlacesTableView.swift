
import UIKit

final class PrefferedPlacesTableView: UITableView {
    private enum Constants {
        static let backgroundColor: UIColor = .white
    }
    
    init() {
        super.init(frame: .zero, style: .grouped)
        setupTableViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableViewConstraints() {
        backgroundColor = Constants.backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        separatorStyle = .none
        register(
            CustomTableViewCell.self,
            forCellReuseIdentifier: CustomTableViewCell.identifier
        )
    }
}
