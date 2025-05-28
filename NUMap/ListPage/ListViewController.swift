
import UIKit

final class ListViewController: UIViewController {
    private enum Constants {
        static let blocksButtonTitle = "By Blocks"
        static let placesButtonTitle = "By Places"
    }
    
    private let tableView = PrefferedPlacesTableView()
    private let presenter = ListPagePresenter()
    private let buttonView = PrefferedPlacesButtonView()
    private let blocksButton = PrefferedPlacesButton(name: Constants.blocksButtonTitle)
    private let placesButton = PrefferedPlacesButton(name: Constants.placesButtonTitle)
    private var searchBarHeight: CGFloat
    
    private var currentMode: PlacesMode = .blocks {
        didSet {
            updateButtonUI()
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        setupTableView()
        configure()
    }
    
    init(searchBarHeight: CGFloat) {
        self.searchBarHeight = searchBarHeight
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.isExpanded(section) ? presenter.getNumberOfRows(for: section) : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.identifier,
            for: indexPath
        ) as? CustomTableViewCell else { fatalError("Error dequeueing cell") }
        
        cell.configure(
            title: presenter.getNameForRow(for: indexPath.row, in: indexPath.section),
            position: presenter.getRowPosition(for: indexPath.row, in: indexPath.section)
        )
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return buttonView.frame.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = SectionButton(
            title: presenter.getNameForSection(section),
            section: section
        )
        button.isExpanded = presenter.isExpanded(section)
        button.addTarget(self, action: #selector(handleSectionTap(_:)), for: .touchUpInside)
        return button
    }

    @objc func handleSectionTap(_ sender: SectionButton) {
        let section = sender.tag
        if presenter.isExpanded(section) {
            presenter.removeFromExpanded(section)
            sender.isExpanded = false
        } else {
            presenter.addToExpanded(section)
            sender.isExpanded = true
        }
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected sub-item: \(presenter.getNameForRow(for: indexPath.row, in: indexPath.section))")
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

//MARK: - List ViewController Setup

private extension ListViewController {
    private func addSubviews() {
        view.addSubview(buttonView)
        view.addSubview(tableView)
        buttonView.addSubview(blocksButton)
        buttonView.addSubview(placesButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: searchBarHeight),
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            buttonView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            
            blocksButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: searchBarHeight),
            blocksButton.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            blocksButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            blocksButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.475),
            
            placesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: searchBarHeight),
            placesButton.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            placesButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            placesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.475),
            
            tableView.topAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: 8),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configure() {
        setupButtonActions()
        updateButtonUI()
    }
}

//MARK: - Setup Blocks and Places Buttons' Logic

private extension ListViewController {
    private func setupButtonActions() {
        blocksButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        placesButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        if sender == blocksButton {
            currentMode = .blocks
            presenter.mode = .blocks
        } else {
            currentMode = .places
            presenter.mode = .places
        }
        presenter.removeAllExpandedSections()
        tableView.reloadData()
    }
    
    private func updateButtonUI() {
        switch currentMode {
        case .blocks:
            blocksButton.isActive = true
            placesButton.isActive = false
        case .places:
            blocksButton.isActive = false
            placesButton.isActive = true
        }
    }
}
