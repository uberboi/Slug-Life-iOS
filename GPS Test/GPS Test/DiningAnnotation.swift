//
//  DiningAnnotation.swift
//  GPS Test
//
//  Created by MAC VM on 11/19/16.
//  Copyright © 2016 Kevin Cai. All rights reserved.
//

import MapKit

class DiningAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var name: String!
    var image: UIImage!
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
