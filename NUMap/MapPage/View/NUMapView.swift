
import UIKit
import MapKit

final class NUMapView: MKMapView {
    private enum Constants {
        static let NULatitude: CLLocationDegrees = 51.090163
        static let NULongtitude: CLLocationDegrees = 71.400055
        static let NULatitudeDelta: CLLocationDegrees = 0.05
        static let NULongtitudeDelta: CLLocationDegrees = 0.05
        static let cameraFromDistance: CLLocationDistance = 1000
        static let cameraPitch: CGFloat = 60
        static let cameraAngle: CGFloat = 283
        
    }
    
    let location = CLLocationCoordinate2D(
        latitude: Constants.NULatitude,
        longitude: Constants.NULongtitude
    )
    let span = MKCoordinateSpan(
        latitudeDelta: Constants.NULatitudeDelta,
        longitudeDelta: Constants.NULongtitudeDelta
    )
//    let maxAllowedDistance: CLLocationDistance = 2000
//    let minZoomLevel: CLLocationDegrees = 0.005
//    let maxZoomLevel: CLLocationDegrees = 0.05
    
    init() {
        super.init(frame: .zero)
        setMapProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setMapProperties() {
        mapType = .satellite
        showsCompass = false
        layoutMargins.bottom = -100
        translatesAutoresizingMaskIntoConstraints = false
        region = MKCoordinateRegion(center: location, span: span)
        
        let camera = MKMapCamera(
            lookingAtCenter: location,
            fromDistance: Constants.cameraFromDistance,
            pitch: Constants.cameraPitch,
            heading: Constants.cameraAngle
        )
        setCamera(camera, animated: true)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
