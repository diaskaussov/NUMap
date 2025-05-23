
import UIKit
import MapKit

final class MapViewController: UIViewController {
    private enum ViewMode {
        case map
        case list
    }
    
    private enum Constants {
        static let mapImage: String =  "mappin.and.ellipse"
        static let listImage: String = "list.bullet"
    }
    
    private let mapView = NUMapView()
    private let mapButton = MenuButton(imageName: Constants.mapImage)
    private let listButton = MenuButton(imageName: Constants.listImage)
    private let backgroundButtonView = BackgroundButtonView()
    private let locationButton = LocationButton()
    
    private var currentMode: ViewMode = .map {
        didSet {
            updateButtonUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        configure()
    }
}

//MARK: - Main ViewController Setup

private extension MapViewController {
    private func addSubviews() {
        view.addSubview(mapView)
        mapView.addSubview(locationButton)
        mapView.addSubview(backgroundButtonView)
        backgroundButtonView.addSubview(mapButton)
        backgroundButtonView.addSubview(listButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundButtonView.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.bottomAnchor),
            backgroundButtonView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            backgroundButtonView.widthAnchor.constraint(equalTo: mapView.widthAnchor, multiplier: 0.5),
            backgroundButtonView.heightAnchor.constraint(equalTo: mapView.heightAnchor, multiplier: 0.08),
            
            locationButton.bottomAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.bottomAnchor),
            locationButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -5),
            locationButton.widthAnchor.constraint(equalTo: mapView.heightAnchor, multiplier: 0.08),
            locationButton.heightAnchor.constraint(equalTo: mapView.heightAnchor, multiplier: 0.08),
            
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
        setupButtonActions()
        updateButtonUI()
    }
}

//MARK: - Setup Map, List and Location Buttons' Logic

private extension MapViewController {
    private func setupButtonActions() {
        mapButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        listButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        if sender == mapButton {
            currentMode = .map
            
        } else {
            currentMode = .list
            let vc = ListViewController(
                mapButton: mapButton,
                listButton: listButton,
                backgroundButtonView: backgroundButtonView
            )
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func updateButtonUI() {
        switch currentMode {
        case .map:
            mapButton.isActive = true
            listButton.isActive = false
        case .list:
            mapButton.isActive = false
            listButton.isActive = true
        }
    }
    
    @objc
    private func locationButtonTapped(_ sender: UIButton) {
        print("Hello")
    }
}
