//
//  Artwork.swift
//  SwiftProject
//
//  Created by Emma Houlé on 30/01/2016.
//  Copyright © 2016 etu. All rights reserved.
//

import MapKit
import Foundation

class Artwork: NSObject, MKAnnotation {
    let thetitle: String
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.thetitle = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var thesubtitle: String {
        return locationName
    }
}