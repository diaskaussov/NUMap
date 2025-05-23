
import UIKit

final class ListViewController: UIViewController {
    private let mapButton: MenuButton
    private let listButton: MenuButton
    private let backgroundButtonView: BackgroundButtonView
    
    init(
        mapButton: MenuButton,
        listButton: MenuButton,
        backgroundButtonView: BackgroundButtonView
    ) {
        self.listButton = listButton
        self.mapButton = mapButton
        self.backgroundButtonView = backgroundButtonView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .purple
        addSubviews()
        setupConstraints()
        configure()
    }
}

private extension ListViewController {
    private func addSubviews() {
        view.addSubview(backgroundButtonView)
        backgroundButtonView.addSubview(mapButton)
        backgroundButtonView.addSubview(listButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundButtonView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            backgroundButtonView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            
            mapButton.bottomAnchor.constraint(equalTo: backgroundButtonView.bottomAnchor),
            mapButton.leadingAnchor.constraint(equalTo: backgroundButtonView.leadingAnchor),
            mapButton.widthAnchor.constraint(equalTo: backgroundButtonView.widthAnchor, multiplier: 0.5),
            mapButton.heightAnchor.constraint(equalTo: backgroundButtonView.heightAnchor),
            
            listButton.bottomAnchor.constraint(equalTo: backgroundButtonView.bottomAnchor),
            listButton.trailingAnchor.constraint(equalTo: backgroundButtonView.trailingAnchor),
            listButton.widthAnchor.constraint(equalTo: backgroundButtonView.widthAnchor, multiplier: 0.5),
            listButton.heightAnchor.constraint(equalTo: backgroundButtonView.heightAnchor)
        ])
    }
    
    private func configure() {
        
    }
}

private extension ListViewController {
    private func setupButtonActions() {
        mapButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        listButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        if sender == mapButton {
            navigationController?.popViewController(animated: true)
        } else {
            listButton.isActive = true
            mapButton.isActive = false
        }
    }
}
