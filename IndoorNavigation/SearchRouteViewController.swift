//
//  SearchRouteViewController.swift
//  indoor navigation a


import UIKit

class SearchRouteViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var typeSelector: UISegmentedControl!
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var tblTopConstr: NSLayoutConstraint!
    
    weak var delegate: FinderInsideDelegate?
    
    var triggeredTextField : String? = nil
    
    var currentRoom: Rooms? = nil
    
    var rooms: [Rooms] = Rooms.allitems()
    
    var pois: [Poi] = Poi.allitems()
    
    var objectsSearchable = [(Double, String, Any)]()
    
    var searchArray = [(Double, String, Any)]()
    
    var searching = false
    
    
    func registerTableViewCells(){
        let cell = UINib(nibName: "indoorTableViewCell", bundle: nil)
        self.tblView.register(cell, forCellReuseIdentifier: "indoorTableViewCell")
    }
    
    @IBAction func typeSelected(_ sender: Any) {
        objectsSearchable =  [(Double, String, Any)]()
        prepareForToSearch(type: typeSelector.selectedSegmentIndex)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCells()
        
        searchBar.delegate = self
        setLayout()
        guard let trigger = triggeredTextField else {return}
        print (trigger)
    
        if (triggeredTextField == "FROM"){
            prepareForFromSearch()
            tblTopConstr.constant = 0
        } else {
            prepareForToSearch(type: 0) // запускает функцию селектора
            tblTopConstr.constant = 28
        }
        
        
      
    }
    
    func prepareForFromSearch(){
        for room in rooms{
            if room.type != 4 {
                objectsSearchable.append ((-1.0, room.name!, room))
            }
        }
        tblView.reloadData()
    }
    
    
    func prepareForToSearch(type: Int) { // по типу вкладки формируем массив выдачи
        guard let currRoom = currentRoom else {return}
        switch typeSelector.selectedSegmentIndex
        {
        case 0: //все
            for room in rooms{
                if room.type != 4 && room.id != currRoom.id {
                objectsSearchable.append ((delegate!.findDistanceFromRoomToRoom(fromRoomId: currRoom.id, toRoomId: room.id), room.name!, room))
                }
            }
            for poi in pois{
                objectsSearchable.append ((delegate!.findDistanceFromRoomToPoi(fromRoomId: currRoom.id, toPoiId: poi.id), poi.name!, poi))
            }
            objectsSearchable = objectsSearchable.sorted(by: { $0.0 < $1.0 })
            tblView.reloadData()
        case 1:
            for room in rooms{
                if (room.type == 1){
                    
                    objectsSearchable.append ((delegate!.findDistanceFromRoomToRoom(fromRoomId: currRoom.id, toRoomId: room.id), room.name!, room))
                }
            }
            objectsSearchable = objectsSearchable.sorted(by: { $0.0 < $1.0 })
            tblView.reloadData()
        case 2:
            for poi in pois{
                if poi.type == 1{
                    objectsSearchable.append ((delegate!.findDistanceFromRoomToPoi(fromRoomId: currRoom.id, toPoiId: poi.id), poi.name!, poi))
                }
            }
            objectsSearchable = objectsSearchable.sorted(by: { $0.0 < $1.0 })
            tblView.reloadData()
            
        case 3:
            for poi in pois{
                if poi.type == 2{
                    objectsSearchable.append ((delegate!.findDistanceFromRoomToPoi(fromRoomId: currRoom.id, toPoiId: poi.id), poi.name!, poi))
                }
            }
            
        case 4:
            for poi in pois{
                if poi.type == 3{
                    objectsSearchable.append ((delegate!.findDistanceFromRoomToPoi(fromRoomId: currRoom.id, toPoiId: poi.id), poi.name!, poi))
                }
            }
            
        case 5:
            for room in rooms{
                if (room.type == 2) || (room.type == 3){
                    objectsSearchable.append ((delegate!.findDistanceFromRoomToRoom(fromRoomId: currRoom.id, toRoomId: room.id), room.name!, room))
                }
            }
            
        default:
            break
        }
        objectsSearchable = objectsSearchable.sorted(by: { $0.0 < $1.0 })
        tblView.reloadData()
    }
    
    func setLayout (){
        if let tf = triggeredTextField { // скрыть селектор и поднять тейбл вью
            if tf == "FROM"{
                typeSelector.isHidden = true
                tblView.frame = CGRect(x: 0, y: 132, width: tblView.frame.size.width, height: 740 );
            } else
            {
                typeSelector.isHidden = false
                tblView.frame = CGRect(x: 0, y: 157, width: tblView.frame.size.width, height: 715 );
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.delegate = self
        
    }
    
    func getObjectMainImage (majorType: String, minorType: Int) -> UIImage? {
        
        switch majorType {
            case "ROOM":
                switch minorType {
                case 0:
                    if let img = UIImage(named: "corridor") {
                        
                        return img
                    } else {
                        return nil
                    }
                case 1:
                    if let img = UIImage(named: "studyRoom") {
                        
                        return img
                    } else {
                        return nil
                    }
                case 2:
                    if let img = UIImage(named: "manToilet") {
                        
                        return img
                    } else {
                        return nil
                    }
                case 3:
                    if let img = UIImage(named: "womenToilet") {
                        return img
                    } else {
                        return nil
                    }
                default:
                    return nil
            }
            case "POI":
                switch minorType {
                case 1:
                    if let img = UIImage(named: "drink") {
                        
                        return img
                    } else {
                        return nil
                    }
                case 2:
                    if let img = UIImage(named: "sitplace") {
                        
                        return img
                    } else {
                        return nil
                    }
                case 3:
                    if let img = UIImage(named: "atm") {
                        
                        return img
                    } else {
                        return nil
                    }
                default: return nil
            }
            default: return nil
        }
    }
    

}

extension SearchRouteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return searchArray.count
        } else {
            return objectsSearchable.count
        }
        
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "indoorTableViewCell") as? indoorTableViewCell
        
        
        if searching {
            // зависимые от комната/poi поля
            if (type(of: searchArray[indexPath.row].2) == Poi.self){ //если POI
                let poi = searchArray[indexPath.row].2 as! Poi
                cell?.nameLab?.text = poi.name!
                cell?.commentLab?.text = poi.comment!
                // get POI floor
                if let floor = poi.roomsrelationship?.floorsrelationship {
                    cell?.floorLab?.text = floor.name!
                } else {
                    cell?.floorLab?.text = "N/A"
                }
                //устанавливаем главную картинку
                if let img = getObjectMainImage(majorType: "POI", minorType: Int(poi.type)) {
                    cell?.mainImg.image = img
                } else {cell?.mainImg.image = nil}
            }
            if (type(of: searchArray[indexPath.row].2) == Rooms.self){ //если Room
                let room = searchArray[indexPath.row].2 as! Rooms
                cell?.nameLab?.text = room.name!
                
                cell?.commentLab?.text = room.comment!
                if let floor = room.floorsrelationship {
                    cell?.floorLab?.text = floor.name!
                } else {
                    cell?.floorLab?.text = "N/A"
                }
                //устанавливаем главную картинку
                if let img = getObjectMainImage(majorType: "ROOM", minorType: Int(room.type)) {
                    cell?.mainImg.image = img
                } else {cell?.mainImg.image = nil}
            }
            
            // независимое поле - расстояние
            if (searchArray[indexPath.row].0 == 0.0)
            {
                cell?.proxLab?.text = String ("Рядом")
                cell?.locPic.isHidden = false
            } else if (searchArray[indexPath.row].0 == -1.0) {
                cell?.proxLab?.text = ""
                cell?.locPic.isHidden = true
            } else {
                cell?.proxLab?.text = String ("\(searchArray[indexPath.row].0 ) м")
                cell?.locPic.isHidden = false
            }
        } else {
                if (type(of: objectsSearchable[indexPath.row].2) == Poi.self){ //если POI
                    let poi = objectsSearchable[indexPath.row].2 as! Poi
                    cell?.nameLab?.text = poi.name!
                    
                    cell?.commentLab?.text = poi.comment!
                    // get POI floor
                    if let floor = poi.roomsrelationship?.floorsrelationship {
                        cell?.floorLab?.text = floor.name!
                    } else {
                        cell?.floorLab?.text = "N/A"
                    }
                    //устанавливаем главную картинку
                    if let img = getObjectMainImage(majorType: "POI", minorType: Int(poi.type)) {
                        cell?.mainImg.image = img
                    } else {cell?.mainImg.image = nil}
                }
                if (type(of: objectsSearchable[indexPath.row].2) == Rooms.self){ //если Room
                    let room = objectsSearchable[indexPath.row].2 as! Rooms
                    cell?.nameLab?.text = room.name!
                    
                    cell?.commentLab?.text = room.comment!
                    if let floor = room.floorsrelationship {
                        cell?.floorLab?.text = floor.name!
                    } else {
                        cell?.floorLab?.text = "N/A"
                    }
                    //устанавливаем главную картинку
                    if let img = getObjectMainImage(majorType: "ROOM", minorType: Int(room.type)) {
                        cell?.mainImg.image = img
                    } else {cell?.mainImg.image = nil}
                }
            
            
                if (objectsSearchable[indexPath.row].0 == 0.0)
                {
                    cell?.proxLab?.text = String ("Рядом")
                    cell?.locPic.isHidden = false
                } else if (objectsSearchable[indexPath.row].0 == -1.0){
                    cell?.proxLab?.text = ""
                    cell?.locPic.isHidden = true
                } else {
                    cell?.proxLab?.text = String ("\(objectsSearchable[indexPath.row].0 ) м")
                    cell?.locPic.isHidden = false
                }
        }
    
        return cell!
    }

    // здесь происходит переход от текущего контроллера к предыдущему с заполнением нужного поля
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let trigger = triggeredTextField else {return}
        
        guard let navVc = navigationController else {
            print ("SearchRouteViewController::tableView::didSelectRowAt:: navigationController doesnt exists")
            return
        }
        
        let findVC = navVc.viewControllers[navVc.viewControllers.capacity - 2] as! FindRouteViewController
        switch trigger {
            case "FROM":
                if searching {
                    let room = searchArray[indexPath.row].2 as! Rooms
                    findVC.roomFrom = room
                    findVC.fromField.text = room.name!
                    findVC.toField.isEnabled = true
                } else {
                    let room = objectsSearchable[indexPath.row].2 as! Rooms
                    findVC.roomFrom = room
                    findVC.fromField.text = room.name!
                    findVC.toField.isEnabled = true
            }
            case "TO":
                if searching {
                    if (type(of: searchArray[indexPath.row].2) == Poi.self){ //если POI
                        let poi = searchArray[indexPath.row].2 as! Poi
                        findVC.poiTo = poi
                        findVC.roomTo = nil
                        findVC.toField.text = poi.name!
                    }
                    if (type(of: searchArray[indexPath.row].2) == Rooms.self){ //если Room
                        let room = searchArray[indexPath.row].2 as! Rooms
                        findVC.roomTo = room
                        findVC.poiTo = nil
                        findVC.toField.text = room.name!
                    }
                } else {
                    if (type(of: objectsSearchable[indexPath.row].2) == Poi.self){ //если POI
                        let poi = objectsSearchable[indexPath.row].2 as! Poi
                        findVC.poiTo = poi
                        findVC.roomTo = nil
                        findVC.toField.text = poi.name!
                    }
                    if (type(of: objectsSearchable[indexPath.row].2) == Rooms.self){ //если Room
                        let room = objectsSearchable[indexPath.row].2 as! Rooms
                        findVC.roomTo = room
                        findVC.poiTo = nil
                        findVC.toField.text = room.name!
                    }
            }
            
            default:
                break
        }
        navVc.popViewController(animated: true)
    }
    
}

extension SearchRouteViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchArray = objectsSearchable.filter({ $0.1.uppercased().contains(searchText.uppercased()) })
        searching = true
        tblView.reloadData()
    }
}

