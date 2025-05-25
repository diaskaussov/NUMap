
import UIKit

protocol LocationSearchBarDelegate: AnyObject {
    func textFieldDidBeginEditing(textField: UITextField)
    
    func textFieldDidChanged(textField: UITextField)
    
    func textFieldDidEndEditing(textField: UITextField)
    
    func textFieldShouldReturn(textField: UITextField)
    
    func cancelButtonTapped()
}

final class LocationSearchBar: UITextField {
    private enum Constants {
        static let cornerRadius: CGFloat = 20
        static let textColor: UIColor = UIColor(
            red: 103.0/255.0,
            green: 102.0/255.0,
            blue: 102.0/255.0,
            alpha: 1.0
        )
        static let backgroundColor: UIColor = UIColor(
            red: 228.0/255.0,
            green: 228.0/255.0,
            blue: 228.0/255.0,
            alpha: 1.0
        )
        static let insetX: CGFloat = 15
        static let insetY: CGFloat = 0
        static let searchButtonName: String = "magnifyingglass"
        static let cancelButtonName: String = "x.circle"
    }
    
    weak var locationSearchBarDelegate: LocationSearchBarDelegate?
    
    private let searchButton = SearchCancelButton(name: Constants.searchButtonName)
    private let cancelButton = SearchCancelButton(name: Constants.cancelButtonName)
    private let buttonContainer = UIView()
    
    init() {
        super.init(frame: .zero)
        setupSearchBarProperties()
        addSubviews()
        setupSearchBarConstraints()
        addFunctionality()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Make placeholder and text fit

extension LocationSearchBar {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: Constants.insetX, dy: Constants.insetY)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: Constants.insetX, dy: Constants.insetY)
    }
}

//MARK: - Setup Search and Cancel Buttons

private extension LocationSearchBar {
    private func setupSearchBarProperties() {
        tintColor = Constants.textColor
        placeholder = "What do you want to visit?"
        backgroundColor = .clear
        returnKeyType = .search
        backgroundColor = Constants.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
        textColor = Constants.textColor
        contentMode = .left
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        self.addSubview(buttonContainer)
        buttonContainer.addSubview(cancelButton)
        buttonContainer.addSubview(searchButton)
    }
    
    private func setupSearchBarConstraints() {
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            buttonContainer.heightAnchor.constraint(equalTo: self.heightAnchor),
            buttonContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15),
            
            cancelButton.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor),
            cancelButton.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            cancelButton.widthAnchor.constraint(equalTo: buttonContainer.widthAnchor, multiplier: 0.8),
            cancelButton.heightAnchor.constraint(equalTo: buttonContainer.heightAnchor, multiplier: 0.8),
            
            searchButton.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor),
            searchButton.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            searchButton.widthAnchor.constraint(equalTo: buttonContainer.widthAnchor, multiplier: 0.8),
            searchButton.heightAnchor.constraint(equalTo: buttonContainer.heightAnchor, multiplier: 0.8)
        ])
        cancelButton.isHidden = true
    }
}

//MARK: - Functionality of Location SearchBar

extension LocationSearchBar {
    func makeCancelButtonAppear(for isSearching: Bool) {
        switch isSearching {
        case true:
            searchButton.isHidden = true
            cancelButton.isHidden = false
        case false:
            searchButton.isHidden = false
            cancelButton.isHidden = true
        }
    }
    
    private func addFunctionality() {
        addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        addTarget(self, action: #selector(textFieldShouldReturn(_:)), for: .primaryActionTriggered)
        cancelButton.addTarget(self, action: #selector(cancelText), for: .touchUpInside)
    }
    
    @objc
    private func textFieldDidBeginEditing(_ textField: UITextField) {
        locationSearchBarDelegate?.textFieldDidBeginEditing(textField: self)
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        locationSearchBarDelegate?.textFieldDidChanged(textField: self)
    }
    @objc
    private func textFieldDidEndEditing(_ textField: UITextField) {
        locationSearchBarDelegate?.textFieldDidEndEditing(textField: self)
    }
    @objc
    private func textFieldShouldReturn(_ textField: UITextField) {
        locationSearchBarDelegate?.textFieldShouldReturn(textField: self)
    }
    
    @objc
    private func cancelText(_ sender: UIButton) {
        self.resignFirstResponder()
        self.text = ""
        locationSearchBarDelegate?.cancelButtonTapped()
    }
}
