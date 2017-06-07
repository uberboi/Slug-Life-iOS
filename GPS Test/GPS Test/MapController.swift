//
//  MapController.swift
//  GPS Test
//
//  Created by Kevin Cai on 10/22/16.
//  Copyright © 2016 Kevin Cai. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate {
    
    //Variables for annotaions
    var coordinates: [[Double]]!
    var names:[String]!
    var imageName:[String]!
    
    //button and label initializations
    @IBOutlet weak var TitleButton: UIButton!
    @IBOutlet weak var gpsinfo: UILabel!
    @IBOutlet weak var c9Button: UIButton!
    @IBOutlet weak var c9Label: UILabel!
    @IBOutlet weak var crownButton: UIButton!
    @IBOutlet weak var crownLabel: UILabel!
    @IBOutlet weak var cowellButton: UIButton!
    @IBOutlet weak var cowellLabel: UILabel!
    @IBOutlet weak var porterButton: UIButton!
    @IBOutlet weak var porterLabel: UILabel!
    @IBOutlet weak var oakesButton: UIButton!
    @IBOutlet weak var oakesLabel: UILabel!
    
    
    //Mapkit initialization
    @IBOutlet weak var mapKit: MKMapView!
    
    //init location manager and get current location
    var locManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    //static locations for all 5 of the dining halls on campus
    let c9Location = CLLocation(latitude: 37.000738, longitude: -122.057787)
    let crownLocation = CLLocation(latitude: 37.000157, longitude: -122.054365)
    let cowellLocation = CLLocation(latitude: 36.996769, longitude: -122.053006)
    let porterLocation = CLLocation(latitude: 36.994226, longitude: -122.065925)
    let oakesLocation = CLLocation(latitude: 36.991595, longitude: -122.065407)
    
    //Updates User Location in Map View
    //Debug -> Location -> Freeway Drive to test
    func mapView(_ mapKit: MKMapView, didUpdate
        userLocation: MKUserLocation) {
        mapKit.centerCoordinate = userLocation.location!.coordinate
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if view.annotation is MKUserLocation
        {
            //Don't proceed with custom call out
            return
        }
        
        let diningAnnotation = view.annotation as! DiningAnnotation
        let views = Bundle.main.loadNibNamed("CustomCalloutView", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutView
        calloutView.diningName.text = diningAnnotation.name
        calloutView.diningImage.image = diningAnnotation.image
        //calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: MKAnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
    
    @IBAction func buttonPress(_ sender: Any) {
        let userLocation = mapKit.userLocation
        let region = MKCoordinateRegionMakeWithDistance( userLocation.location!.coordinate, 2000, 2000)
        mapKit.setRegion(region, animated: true)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        //Design here:
        //Get current location if any button is pressed
        //If gpsinfo button pressed, return current position
        //else return the current position and the position of the dining
        //hall and some indication of
        //"yes, you are here" or "no, you are not here"
        //
        currentLocation = locManager.location!
        var lat = String(format: "%.5f", currentLocation.coordinate.latitude)
        var long = String(format: "%.5f", currentLocation.coordinate.longitude)
        //        gpsinfo.text = "\(lat), \(long)"
    switch sender
    {
        case TitleButton:
        //gpsinfo.text = "\(lat), \(long)"
        let userLocation = mapKit.userLocation
        let region = MKCoordinateRegionMakeWithDistance(
            userLocation.location!.coordinate, 2000, 2000)
    
        mapKit.setRegion(region, animated: true)
        break
        case c9Button:
            var distC9 = currentLocation.distance(from: c9Location)
            print("Current Location: ")
            print(currentLocation)
            gpsinfo.text = "You pressed c9"
            gpsinfo.text = "\(distC9)"
            //Function to compare within dining hall range
            if distC9 <= 50
            {
                gpsinfo.text = "You are at College 9 and 10 Dining!"
            } else {
                var distAway = (distC9 - 50).rounded()
                gpsinfo.text = "You are \(distAway) meters away."
            }
            break
        case crownButton:
            var distCrown = currentLocation.distance(from: crownLocation)
            gpsinfo.text = "\(distCrown)"
            //Function to compare within dining hall range
            if distCrown <= 50
            {
                gpsinfo.text = "You are at Crown & Merril Dining!"
            } else {
                var distAway = (distCrown - 50).rounded()
                gpsinfo.text = "You are \(distAway) meters away."
            }
            break
        case cowellButton:
            var distCowell = currentLocation.distance(from: cowellLocation)
            gpsinfo.text = "\(distCowell)"
            //Function to compare within dining hall range
            if distCowell <= 50
            {
                gpsinfo.text = "You are at Cowell & Stevenson!"
            } else {
                var distAway = (distCowell - 50).rounded()
                gpsinfo.text = "You are \(distAway) meters away."
            }
            break
        case porterButton:
            let distPorter = currentLocation.distance(from: porterLocation)
            gpsinfo.text = "\(distPorter)"
            //Function to compare within dining hall range
            if distPorter <= 50
            {
                gpsinfo.text = "You are at Porter & Kresge Dining!"
            } else {
                var distAway = (distPorter - 50).rounded()
                gpsinfo.text = "You are \(distAway) meters away."
            }
            break
        case oakesButton:
            let distOakes = currentLocation.distance(from: oakesLocation)
            gpsinfo.text = "\(distOakes)"
            //Function to compare within dining hall range
            if distOakes <= 50
            {
                gpsinfo.text = "You are at Oakes & College 8 Dining!"
            } else {
                var distAway = (distOakes - 50).rounded()
                gpsinfo.text = "You are \(distAway) meters away."
            }
            break
        default:
            gpsinfo.text = "You pressed <unsupported button>"
            break
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.locManager.requestAlwaysAuthorization()
        self.locManager.requestWhenInUseAuthorization()
        self.locManager.startUpdatingLocation()
        mapKit.delegate = self
        mapKit.showsUserLocation = true
        
        //Annotation info
        coordinates = [[37.000738, -122.057787],
                       [37.000157, -122.054365],
                       [36.996769, -122.053006],
                       [36.994226, -122.065925],
                       [36.991595, -122.065407]]
        names = ["College 9 & 10", "Crown & Merril", "Cowell & Stevenson", "Porter & Kresge", "Oakes & College 8"]
        imageName = ["nine_ten_dinninghall.jpg", "crown_merril_dininghall.jpg", "cowell_stevenson_dininghall.jpg",
                     "porter_kresge_dininghall.jpg", "college_eight_dininghall.jpg"]
        
        for i in 0...4
        {
            let coordinate = coordinates[i]
            let point = DiningAnnotation(coordinate: CLLocationCoordinate2D(latitude: coordinate[0] , longitude: coordinate[1] ))
            point.image = UIImage(named: imageName[i])
            point.name = names[i]
            self.mapKit.addAnnotation(point)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
