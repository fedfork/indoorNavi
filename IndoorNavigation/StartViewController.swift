//
//  StartViewController.swift
//  indoor navigation a


import UIKit
import Firebase

class StartViewController: UIViewController {

    var connected: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func loadFromDatabase () {
       
        if ReachabilityTest.isConnectedToNetwork(){
            let firDb = WriteBase()
            FirebaseApp.configure()
            
            
            
            let ref = Database.database().reference()
            
            //показываем viewcontroller
            
            
            ref.observeSingleEvent(of: .value, with: { snapshot in
                
             
                
                firDb.readRoom1(snapshot: snapshot)
                
                
                allVertexes = Vertex.allitems()
                allEdges = Edge.allitems()
                allRooms = Rooms.allitems()
                allPois = Poi.allitems()
                allFloors = Floors.allitems()
                getDataBeacons = Beacons.allitems()
                allFloors = allFloors.sorted(by: { $0.name ?? "kek" < $1.name ?? "kek" })
                
                
                
                
                self.performSegue(withIdentifier: "showMain", sender: nil)
                
            })
        } else
        {
            
            let alert = UIAlertController(title: "Нет подключения к интернету",
                                          message: "Попробовать еще раз?",
                                          preferredStyle: .alert)
            
            let againAction = UIAlertAction(title: "Да",
                                            style: .destructive) { (action) in
                                                self.loadFromDatabase()
            }
            
            let cancelAction = UIAlertAction(title: "Выход",
                                             style: .cancel) { (action) in
                                                exit (0)
            }
            
            
            alert.addAction(againAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    override func viewDidAppear(_ animated: Bool){
        
        loadFromDatabase()
    }
    
}
