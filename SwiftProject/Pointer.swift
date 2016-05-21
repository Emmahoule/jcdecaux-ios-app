//
//  Pointer.swift
//  SwiftProject
//
//  Created by Emma Houlé on 30/01/2016.
//  Copyright © 2016 etu. All rights reserved.
//

import MapKit
import Foundation

class Pointer: NSObject, MKAnnotation {
    
    // MARK: - Attributs
    
    /// Déclaration d'une constante qui contiendra les coordonnées pour positionner le pointer
    let coordinate: CLLocationCoordinate2D
    
    
    // MARK: - Initialisation
    
    /**
    Initialisation du pointer
    
    - paramètres coordinate : les coordonnées du pointer
    
    - return : aucun
    */
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
    
}
