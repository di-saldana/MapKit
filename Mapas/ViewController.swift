//
//  ViewController.swift
//  Mapas
//
//  Created by Dianelys Saldaña on 3/11/24.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    enum TipoMapa: Int {
        case mapa = 0
        case satelite
    }
    
    var numPin = 0
    
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var mapa: MKMapView! {
        didSet {
            mapa.mapType = .standard
            mapa.delegate = self
            let alicanteLocation =
                CLLocationCoordinate2D(latitude: 38.3453,
                                       longitude: -0.4831)
            centerMapOnLocation(mapView: mapa, loc: alicanteLocation)
        }
    }
    
    @IBOutlet weak var pin: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func centerMapOnLocation(mapView: MKMapView, loc: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 4000
        let coordinateRegion =
            MKCoordinateRegion(center: loc,
                               latitudinalMeters: regionRadius,
                               longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("Cambiada la posición del mapa: \(mapView.centerCoordinate)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("Devolviendo vista para anotación: \(annotation)")
        let pin = annotation as? Pin
        let view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)

        view.tintColor = UIColor.red // pinTintColor
        view.animatesWhenAdded = true // animatesDrop
        view.canShowCallout = true
        let thumbnailImageView = UIImageView(frame: CGRect(x:0, y:0, width: 59, height: 59))
        thumbnailImageView.image = pin?.thumbImage
        view.leftCalloutAccessoryView = thumbnailImageView
        view.rightCalloutAccessoryView = UIButton(type:UIButton.ButtonType.detailDisclosure)
        return view;
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let pin = view.annotation as? Pin {
            performSegue(withIdentifier: "DetalleImagen", sender: pin.thumbImage)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetalleImagen" {
            if let destinationViewController = segue.destination as? DetalleViewController,
               let thumbnailImage = sender as? UIImage {
                destinationViewController.thumbnailImage = thumbnailImage
            }
        }
    }
    
    @IBAction func seleccion(_ sender: UISegmentedControl) {
        let tipoMapa = TipoMapa(rawValue: sender.selectedSegmentIndex)!
        switch (tipoMapa) {
            case .mapa:
                mapa.mapType = MKMapType.standard
            case .satelite:
                mapa.mapType = MKMapType.satellite
        }
    }
    
    @IBAction func addPin(_ sender: UIBarButtonItem) {
        numPin += 1
        let pin = Pin(num: numPin, coordinate: mapa.centerCoordinate)
        mapa.addAnnotation(pin)
    }
    
}

