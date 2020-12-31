//
//  AddressDetailsTableViewCell.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit
import MapKit

class AddressDetailsTableViewCell: UITableViewCell, NibReusable {

    struct Parameters: Equatable {
        let fullAddress: String
        let location: CLLocationCoordinate2D?
        static func == (lhs: AddressDetailsTableViewCell.Parameters, rhs: AddressDetailsTableViewCell.Parameters) -> Bool {
            return lhs.fullAddress == rhs.fullAddress &&
                lhs.location?.latitude == rhs.location?.latitude &&
                rhs.location?.longitude == rhs.location?.longitude
        }
    }
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        mapView.layer.cornerRadius = 20
    }
    
    deinit {
        mapView.delegate = nil
        mapView.removeAnnotations(mapView.annotations)
    }
    
    func render(with parameters: Parameters) {
        addressLabel.text = parameters.fullAddress
        renderMap(location: parameters.location)
    }
    
    private func renderMap(location: CLLocationCoordinate2D?) {
        guard let location = location else {
            mapView.isHidden = true
            return
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        configureMapView(location: location, annotation: annotation)
    }
}

extension AddressDetailsTableViewCell: MKMapViewDelegate {
    private func configureMapView(location: CLLocationCoordinate2D,
                                  annotation: MKPointAnnotation) {
        mapView.delegate = self
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        let mapcamera = MKMapCamera(lookingAtCenter: location,
                                    fromDistance: 500,
                                    pitch: 25,
                                    heading: 0)
        mapView.mapType = .standard
        mapView.setCamera(mapcamera, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: String(describing: annotation))
        annotationView.image = R.image.pizzannotation()
        annotationView.transform = .init(scaleX: 0.5, y: 0.5)
        return annotationView
    }
}
