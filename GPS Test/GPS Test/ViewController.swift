//
//  ViewController.swift
//  GPS Test
//
//  Created by Kevin Cai on 10/22/16.
//  Copyright © 2016 Kevin Cai. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit



class ViewController: UIViewController, MKMapViewDelegate {
    //webView initializations
    @IBOutlet weak var cowellWebView: UIWebView!
    @IBOutlet weak var porterWebView: UIWebView!
    @IBOutlet weak var crownWebView: UIWebView!
    @IBOutlet weak var c9WebView: UIWebView!
    @IBOutlet weak var oakesWebView: UIWebView!
    
    //button and label initializations
    @IBOutlet weak var gpsinfo: UILabel!
    @IBOutlet weak var c9Label: UILabel!
    @IBOutlet weak var crownLabel: UILabel!
    @IBOutlet weak var cowellLabel: UILabel!
    @IBOutlet weak var porterLabel: UILabel!
    @IBOutlet weak var oakesLabel: UILabel!
    //voting buttons
    @IBOutlet weak var c8_crowded: UIButton!
    @IBOutlet weak var c8_not: UIButton!
    @IBOutlet weak var c9_crowded: UIButton!
    @IBOutlet weak var c9_not: UIButton!
    @IBOutlet weak var crown_crowded: UIButton!
    @IBOutlet weak var crown_not: UIButton!
    @IBOutlet weak var cowell_crowded: UIButton!
    @IBOutlet weak var cowell_not: UIButton!
    @IBOutlet weak var porter_crowded: UIButton!
    @IBOutlet weak var porter_not: UIButton!
    //crowded count
    @IBOutlet weak var c9crowdLevel: UILabel!
    @IBOutlet weak var c9noCrowd: UILabel!
    @IBOutlet weak var crownCrowdLevel: UILabel!
    @IBOutlet weak var crownNoCrowd: UILabel!
    @IBOutlet weak var cowellCrowdLevel: UILabel!
    @IBOutlet weak var cowellNoCrowd: UILabel!
    @IBOutlet weak var porterCrowdLevel: UILabel!
    @IBOutlet weak var porterNoCrowd: UILabel!
    @IBOutlet weak var c8crowdLevel: UILabel!
    @IBOutlet weak var c8noCrowd: UILabel!
    
    
    //init location manager and get current location
    var locManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    //static locations for all 5 of the dining halls on campus
    let c9Location = CLLocation(latitude: 37.000738, longitude: -122.057787)
    let crownLocation = CLLocation(latitude: 37.000157, longitude: -122.054365)
    let cowellLocation = CLLocation(latitude: 36.996769, longitude: -122.053006)
    let porterLocation = CLLocation(latitude: 36.994226, longitude: -122.065925)
    let oakesLocation = CLLocation(latitude: 36.991595, longitude: -122.065407)

    //Boolean variables
    var c9Check = false
    var crownCheck = false
    var cowellCheck = false
    var porterCheck = false
    var oakesCheck = false
    
    @IBOutlet weak var c9tButton: UIButton!
    @IBAction func c9_attending(_ sender: UIButton) {
        currentLocation = locManager.location!
        var distC9 = currentLocation.distance(from: c9Location)
        if distC9 <= 50
        {
            c9Label.text = "You are at College 9 and 10 Dining!"
            c9Check = true
            c9_crowded.isHidden = false
            c9_not.isHidden = false
        } else {
            c9Label.text = "You are too far from this Dining Hall!"
            //c9Label.text = "\(distC9)"
            c9Check = false
            c9_crowded.isHidden = true
            c9_not.isHidden = true
        }
    }
    
    @IBOutlet weak var crowntButton: UIButton!
    @IBAction func crown_attending(_ sender: UIButton) {
        currentLocation = locManager.location!
        var distCrown = currentLocation.distance(from: crownLocation)
        if distCrown <= 50
        {
            crownLabel.text = "You are at Crown & Merril Dining!"
            crownCheck = true
            crown_crowded.isHidden = false
            crown_not.isHidden = false
        } else {
            crownLabel.text = "You are too far from this Dining Hall!"
            crownCheck = false
            crown_crowded.isHidden = true
            crown_not.isHidden = true
        }
    }
    
    
    @IBOutlet weak var cowelltButton: UIButton!
    @IBAction func cowell_attending(_ sender: UIButton) {
        currentLocation = locManager.location!
        var distCowell = currentLocation.distance(from: cowellLocation)
        if distCowell <= 50
        {
            cowellLabel.text = "You are at Cowell & Stevenson Dining!"
            cowellCheck = true
            cowell_crowded.isHidden = false
            cowell_not.isHidden = false
        } else {
            cowellLabel.text = "You are too far from this Dining Hall!"
            cowellCheck = false
            cowell_crowded.isHidden = true
            cowell_not.isHidden = true
        }
        
    }
    
    @IBOutlet weak var portertButton: UIButton!
    @IBAction func porter_attending(_ sender: UIButton) {
        currentLocation = locManager.location!
        var distPorter = currentLocation.distance(from: cowellLocation)
        if distPorter <= 50
        {
            porterLabel.text = "You are at Porter & Kresge Dining!"
            porterCheck = true
            porter_crowded.isHidden = false
            porter_not.isHidden = false
        } else {
            porterLabel.text = "You are too far from this Dining Hall!"
            porterCheck = false
            porter_crowded.isHidden = true
            porter_not.isHidden = true
        }
    }
    
    
    @IBOutlet weak var oakestButton: UIButton!
    @IBAction func oakes_attending(_ sender: AnyObject) {
        currentLocation = locManager.location!
        var distOakes = currentLocation.distance(from: oakesLocation)
        if distOakes <= 50
        {
            oakesLabel.text = "You are at Oakes & College 8 Dining!"
            oakesCheck = true
            c8_crowded.isHidden = false
            c8_not.isHidden = false
        } else {
            oakesLabel.text = "You are too far from this Dining Hall!"
            oakesCheck = false
            c8_crowded.isHidden = true
            c8_not.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.locManager.requestAlwaysAuthorization()
        self.locManager.requestWhenInUseAuthorization()
        self.locManager.startUpdatingLocation()
        //mapKit.delegate = self
        //mapKit.showsUserLocation = true
        var random = arc4random_uniform(5)
        
        if (self.title == "Cowell/Stevenson")
        {
            cowellCrowdLevel.text = String(arc4random_uniform(5))
            cowellNoCrowd.text = String(arc4random_uniform(5))
            print("Cowell")

            let url = NSURL (string: "http://nutrition.sa.ucsc.edu/menuSamp.asp?locationNum=05&locationName=Cowell&sName=&naFlag=")
            let requestObj = NSURLRequest(url: url as! URL)
            cowellWebView.isUserInteractionEnabled = true
            
            cowellWebView.loadRequest(requestObj as URLRequest)
        }
        else if (self.title == "Porter/Kresge")
        {
            porterCrowdLevel.text = String(arc4random_uniform(5))
            porterNoCrowd.text = String(arc4random_uniform(5))
            print("Porter")

            let url = NSURL (string: "http://nutrition.sa.ucsc.edu/menuSamp.asp?locationNum=25&locationName=Porter&sName=&naFlag=")
            let requestObj = NSURLRequest(url: url as! URL)
            porterWebView.isUserInteractionEnabled = true
            
            porterWebView.loadRequest(requestObj as URLRequest)
        }
        else if (self.title == "Crown/Merril")
        {
            crownCrowdLevel.text = String(arc4random_uniform(5))
            crownNoCrowd.text = String(arc4random_uniform(5))
            print("Crown")

            let url = NSURL (string: "http://nutrition.sa.ucsc.edu/menuSamp.asp?locationNum=20&locationName=Crown+Merrill&sName=&naFlag=")
            let requestObj = NSURLRequest(url: url as! URL)
            crownWebView.isUserInteractionEnabled = true
            
            crownWebView.loadRequest(requestObj as URLRequest)
        }
        else if (self.title == "C9/C10")
        {
            c9crowdLevel.text = String(arc4random_uniform(5))
            c9noCrowd.text = String(arc4random_uniform(5))
            print("C9")

            let url = NSURL (string: "http://nutrition.sa.ucsc.edu/menuSamp.asp?locationNum=40&locationName=College+Nine+%26+Ten&sName=&naFlag=")
            let requestObj = NSURLRequest(url: url as! URL)
            c9WebView.isUserInteractionEnabled = true
            
            c9WebView.loadRequest(requestObj as URLRequest)
        }
        else if (self.title == "Oakes/C8")
        {
            c8crowdLevel.text = String(arc4random_uniform(5))
            c8noCrowd.text = String(arc4random_uniform(5))
            print("Oakes")
            
            let url = NSURL (string: "http://nutrition.sa.ucsc.edu/menuSamp.asp?locationNum=30&locationName=Rachel+Carson+Oakes+Dining+Hall&sName=&naFlag=")
            let requestObj = NSURLRequest(url: url as! URL)
            oakesWebView.isUserInteractionEnabled = true
            
            oakesWebView.loadRequest(requestObj as URLRequest)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

