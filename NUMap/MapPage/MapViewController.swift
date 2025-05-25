
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
    
    private let listViewController = ListViewController()
    private let locationSearchBar = LocationSearchBar()
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
        setupListViewController()
        configure()
    }
}

//MARK: - Main ViewController Setup

private extension MapViewController {
    private func addSubviews() {
        view.addSubview(mapView)
        view.addSubview(locationSearchBar)
        view.addSubview(locationButton)
        view.addSubview(backgroundButtonView)
        backgroundButtonView.addSubview(mapButton)
        backgroundButtonView.addSubview(listButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            locationSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            locationSearchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            locationSearchBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            locationSearchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backgroundButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundButtonView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            backgroundButtonView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            
            locationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            locationButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            locationButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            
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
        locationSearchBar.locationSearchBarDelegate = self
        setupButtonActions()
        updateButtonUI()
    }
}

//MARK: - Setup List View Controller

private extension MapViewController {
    private func setupListViewController() {
        self.addChild(listViewController)
        view.addSubview(listViewController.view)
        listViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            listViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        listViewController.view.isHidden = true
        listViewController.didMove(toParent: self)
        view.bringSubviewToFront(backgroundButtonView)
        view.bringSubviewToFront(locationSearchBar)
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
            listViewController.view.isHidden = true
        } else {
            currentMode = .list
            listViewController.view.isHidden = false
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

//MARK: - Search Bar Delegate and Logic

extension MapViewController: LocationSearchBarDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        print("Text started editing")
        locationSearchBar.makeCancelButtonAppear(for: true)
    }
    
    func textFieldDidChanged(textField: UITextField) {
        print("Text is changing")
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("Text is done editing")
        locationSearchBar.makeCancelButtonAppear(for: false)
    }
    
    func textFieldShouldReturn(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func cancelButtonTapped() {
        print("Cancel button tapped")
        locationSearchBar.text = ""
        locationSearchBar.resignFirstResponder()
        locationSearchBar.makeCancelButtonAppear(for: false)
    }
}
