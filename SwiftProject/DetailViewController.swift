//
//  DetailViewController.swift
//  SwiftProject
//
//  Created by Emma Houlé on 30/01/2016.
//  Copyright © 2016 etu. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class DetailViewController: UIViewController {

    // MARK: - Attributs

    /// Déclaration des labels qui contiendront les données
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailAddress: UILabel!
    @IBOutlet weak var detailBikeStands: UILabel!
    @IBOutlet weak var detailABikeStands: UILabel!
    @IBOutlet weak var detailABikes: UILabel!
    @IBOutlet weak var detailStatus: UILabel!
    @IBOutlet weak var detailBanking: UILabel!
    
    /// Déclaration d'un MapView qui accueillera la map
    @IBOutlet weak var detailMap: MKMapView!
    
    /// Déclaration d'un tableau qui sert à passer les informations entre les 2 vues
    var detailInfos:[String] = [];
    
    
    // MARK: - Initialisation de la vue
    
    /**
    Chargement et initialisation de la vue
    
    - paramètres : pas de paramètres
    
    - return : aucun
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Récupération des données de la cellule selectionnée, et affichage des données
        
        /// Nom de la station
        var name = detailInfos[0]
        let regex = try! NSRegularExpression(pattern: "^[0-9]{5}+(\\s)*-\\s|^[0-9]{4}+(\\s)*-\\s", options: .CaseInsensitive)
        name = regex.stringByReplacingMatchesInString(name, options: [], range: NSRange(0..<name.utf16.count), withTemplate: "")
        detailName.text = name
        
        /// Titre de la vue
        navigationItem.title = name
        
        /// Adresse
        detailAddress.text = detailInfos[1]
        
        /// Nombre total d'emplacements
        detailBikeStands.text = detailInfos[2] + " emplacements"
        
        //// Nombre de points d'attache disponibles
        detailABikeStands.text = detailInfos[3]
        
        //// Nombre de vélos disponibles et opérationnels
        detailABikes.text = detailInfos[4]
        
        /// Statut
        if (detailInfos[5] == "OPEN") {
            detailStatus.text = "Station ouverte"
        } else {
            detailStatus.text = "Station fermée"
        }
        
        /// Terminal de paiement
        if (detailInfos[6]=="Optional(true)") {
            detailBanking.text = "Terminal de paiement disponible"
        } else {
            detailBanking.text = "Terminal de paiement non disponible"
        }
        
        /// Carte
        
        //// Récupération des coordonnées
        let latitude:Double = Double(detailInfos[7])!
        let longitude:Double = Double(detailInfos[8])!

        //// Initialisation de la position et du zoom
        let stationPosition = CLLocation(latitude: latitude, longitude: longitude)
        let zoom: CLLocationDistance = 1000
        
        //// Création du pointer
        let pointer = Pointer(
            coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        
        //// Création de la carte
        createMap(stationPosition, zoom: zoom, pointer: pointer)
        
    }
    
    /**
     Création de la carte en fonction de la position de la station, du zoom et du pointer
     
     - paramètre position : les coordonnées de la station
     - paramètre zoom : la zone visible sur la carte
     - paramètre pointer : le pointeur sur la station
     
     - return : aucun
     */
    func createMap(position: CLLocation, zoom:CLLocationDistance, pointer:Pointer) {
        let coordinateZone = MKCoordinateRegionMakeWithDistance(
            position.coordinate,
            zoom * 2.0,
            zoom * 2.0
        )
        detailMap.addAnnotation(pointer)
        detailMap.setRegion(coordinateZone, animated: true)
    }
    
    /**
     Gestion de la mémoire
     
     - paramètres : aucun
     
     - return : aucun
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
