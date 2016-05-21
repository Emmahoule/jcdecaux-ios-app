//
//  TableViewController.swift
//  SwiftProject
//
//  Created by Emma Houlé on 30/01/2016.
//  Copyright © 2016 etu. All rights reserved.
//

import UIKit


class TableViewController: UITableViewController {
    
    // MARK: - Attributs 
    
    /// Tableau de type JSON qui contiendra les données reçues de l'API
    var datas:JSON? = []
    
    /// Constantes qui contiennent les paramètres pour appeler l'API
    let city:String = "Lyon"
    let apiKey:String = "3ef68c3a65bf656b618871662fce8bd8c5125008"
    
    
    // MARK: - Initialisation de la vue
    
    /**
    Chargement et initialisation de la vue, appel de l'API
    
    - paramètres : pas de paramètres
    
    - return : aucun
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        appelAPI(self.city, apiKey: self.apiKey)
    }
    
    /**
    Appel de l'API, gestion des erreurs, et stockage des données reçues dans le tableau datas[]

     - paramètre city : la ville pour laquelle la requête sera faite
     - paramètre apiKey : la clé pou accéder à l'API jcdecaux
     
     - return : aucun
     */
    func appelAPI(city:String, apiKey:String) {
        
        /// Création de l'URL à interroger
        let endpoint :String = "https://api.jcdecaux.com/vls/v1/stations?contract="+city+"&apiKey="+apiKey
        guard let url = NSURL (string: endpoint)
            else {
                print("Impossible de créer l'url")
                return
        }
        let urlRequest = NSURLRequest(URL : url)
        
        /// Création et configuration d'une session
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        /// Création d'une tâche pour gérer les erreurs, remplir le tableau datas[] et recharger la table view
        let task = session.dataTaskWithRequest(urlRequest, completionHandler :{(data, response, error) in
            
            //// Gestion des erreurs
            guard let responseData = data else {
                print("Erreur : Aucune donnée reçue")
                return
            }
            guard error == nil else {
                print("Erreur lors de la requête")
                print(error)
                return
            }
            
            //// Stockage des données reçues dans le tableau datas[]
            self.datas = JSON(data: responseData)
            
            //// Rechargement de la Table view
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        })
        
        /// Envoie de la requête
        task.resume()
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

    
    // MARK: - Table view data source

    /**
    Gestion du nombre de sections dans la table view
    
    - paramètres tableView : la table view
    
    - return : le nombre de sections dans la table view
    */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    /**
    Gestion du nombre de lignes dans la table view
     
     - paramètres tableView : la table view
     - paramètres numberOfRowsInSection : le nombre de lignes d'une section donnée
     
     - return : le nombre de lignes dans la table view
     */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// Retourne le nombre de ligne du tableau datas[]
        return self.datas!.count
    }

    /**
    Création du contenu d'une cellule dans la table view
     
     - paramètres tableView : la table view
     - paramètres cellForRowAtIndexPath : la cellule à un index donné
     
     - return : le contenu de la cellule
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        /// Sélection de la vue de cellule à utiliser
        let cell =  tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell
        
        // Récupération de l'index de la cellule
        let row:Int = indexPath.row
        
        /// Récupération dans le tableau datas[] des infos nécessaires, et ajout de ces infos dans les labels correspondant
        
        //// Nom de la station
        var name = (self.datas![row]["name"].string)!
        let regex = try! NSRegularExpression(pattern: "^[0-9]{5}+(\\s)*-\\s|^[0-9]{4}+(\\s)*-\\s", options: .CaseInsensitive)
        name = regex.stringByReplacingMatchesInString(name, options: [], range: NSRange(0..<name.utf16.count), withTemplate: "")
        cell.cellName!.text = name
        
        //// Nombre de points d'attache disponibles pour y ranger un vélo
        cell.cellABikeStands!.text = " \(self.datas![row]["available_bike_stands"].int!) emplacements libres"
        
        //// le nombre de vélos disponibles et opérationnels
        cell.cellABikes!.text = " \(self.datas![row]["bike_stands"].int!) vélos disponibles"
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    /**
    Gestion de la navigation entre la liste des données (TableViewController) et leur détail (DetailViewController)
    
    - paramètres segue : les informations sur les contrôleurs des vue impliquées dans la transition
    - paramètres sender : l'objet qui a initié la transition
     
    - return : aucun
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        /// Récupération de la nouvelle vue vers laquelle on veut aller
        if segue.identifier == "showDetails" {
            let detailView = segue.destinationViewController as! DetailViewController
            let indexPath: NSIndexPath = tableView.indexPathForSelectedRow!
            
            /// Passage des données à la nouvelle vue
            let row: Int = indexPath.row
            detailView.detailInfos = [self.datas![row]["name"].string!, self.datas![row]["address"].string!, "\(self.datas![row]["bike_stands"].int!)", "\(self.datas![row]["available_bike_stands"].int!)", "\(self.datas![row]["available_bikes"].int!)", self.datas![row]["status"].string!, "\(self.datas![row]["banking"].bool)",  "\(self.datas![row]["position"]["lat"].double!)", "\(self.datas![row]["position"]["lng"].double!)"]
        }
    }
    

}
