//
//  ViewController.swift
//  indoor navigation a


import UIKit
import CoreLocation
import CoreBluetooth
import Firebase

var allRooms = [Rooms]()
var allFloors = [Floors]()
var allVertexes = [Vertex]()
var allEdges = [Edge]()
var getDataBeacons = [Beacons]()
var allPois = [Poi]()


private var graph: Graph = Graph(edgesList: allEdges, vertexesList: allVertexes)

class ViewController: UIViewController, CLLocationManagerDelegate, FinderInsideDelegate {
    
    
    
    //путь в виде подсветки комнат
    var navPathRooms: [Rooms] = []
    var currRoomIndex = 0
    var pathVertexes: [Vertex] = []
    
    var toPoiId: String? = nil
    
    @IBOutlet var leadingC: NSLayoutConstraint!
    @IBOutlet var trailingC: NSLayoutConstraint!
    
    @IBOutlet weak var centrateButton: UIButton!
    
    @IBAction func currLocCentrateButton(_ sender: Any) {
            mapView.centrateAroundCurrLoc()
        }
    
    
    @IBOutlet weak var stopshowbutton: UIButton!
    
    
    @IBAction func StopShow(_ sender: Any) {
        stopshowbutton.isHidden = true
        mapView.needsPathBuild = false
        
        if mapView.needNavigating { // если производится подсветка комнат
           interruptNavigating()
        }
    }
    
    var hamburgerMenuIsVisible = false
    @IBAction func hamburgerBtnTapped(_ sender: Any) {
       
        if !hamburgerMenuIsVisible {
            leadingC.constant = 250
          
            trailingC.constant = -250

            
            //1
            hamburgerMenuIsVisible = true
        } else {
            
            leadingC.constant = 0
            trailingC.constant = 0

            
            //2
            hamburgerMenuIsVisible = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The animation is complete!")
        }
     
        
        mapView!.currentFloorLoc = allFloors[0]
        mapView!.currentPosition = CGPoint(x:80, y: 70)
        

    }

    
    @IBOutlet weak var dirLabel: UILabel!
    
    
    @IBOutlet weak var mapView: MapView! {
        didSet {
            let pinch = UIPinchGestureRecognizer(target: mapView, action: #selector(MapView.adjustMapScale(byHandlingGestureRecognizer:)))
            mapView.addGestureRecognizer(pinch)
            
            let pan = UIPanGestureRecognizer(target: mapView, action: #selector(MapView.adjustMapOffset(byHandlingGestureRecognizer:)))
            mapView.isUserInteractionEnabled = true
            mapView.addGestureRecognizer(pan)
            
            let tap = UITapGestureRecognizer(target: mapView, action: #selector(MapView.getTappedRectangle(UsingHandlingGestureRecognizer:)))
            mapView.addGestureRecognizer(tap)
            
            let longPress = UILongPressGestureRecognizer(target: mapView,  action: #selector(MapView.searchFromThisRoom(longPressRecognizer:)))
            mapView.addGestureRecognizer(longPress)
            
            mapView.finderInsideDelegate = self
        }
    }
    @IBAction func floorStepper(_ sender: UIStepper) {

        if (allFloors.capacity == 0) {return}
        mapView.currentFloor = allFloors[Int(sender.value)]
        currentFloorLabel.text = "Этаж: \(Int(sender.value)+1)"
        
        
        
    }
    
    @IBOutlet weak var currentFloorLabel: UILabel!
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)

        self.mapView.updateMapView += 1
    }
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // убрать стрелку
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        // the default direction is right
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        
        
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
        

        locationManager.delegate = self
        
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.headingFilter = 3
        locationManager.startUpdatingHeading()
        
        mapView.currentFloor = allFloors[0]
        currentFloorLabel.text = "Этаж: \(1)"
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    //обновление угла поворота компаса в mapView
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading)
    {
        
        let axisH = mapView.verticalAxisHeading
        
        // выстраиваем новую систему координат
        var arrowH : CLLocationDirection
        let newH = newHeading.magneticHeading
        
        if  newH > axisH
        {
            arrowH = newH - axisH
        }
        else {
            arrowH = 360 - (axisH-newH)
        }
        
        print (newHeading)
        mapView.arrowHeading = arrowH
        return
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "10F86430-1346-11E4-9191-0800200C9A66")!
        
        
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "a")
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    // задает текущее местоположение при наличии биконов. вызывается только тогда, когда в поле зрения попал хотя бы один бикон
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print (beacons.count)
        print (getDataBeacons.count)
        
        if beacons.count > 0, getDataBeacons.count > 0, beacons.count <= getDataBeacons.count {

            
            
            var allBeacons = [(Int,Double,Beacons)]()
            for current in getDataBeacons {
                allBeacons.append((3, 0.0, current))
            }
            
            var usedBeacons = Set<Int>()
            
            
            for index in beacons.indices {
                //let majorminor = String(Int(truncating: current.major)) + " " + String(Int(truncating: current.minor))
                var distance: Int
                if beacons[index].proximity == .immediate {
                    distance = 0
                }
                else if beacons[index].proximity == .near {
                    distance = 1
                }
                else if beacons[index].proximity == .far {
                    distance = 2
                    
                }
                else {
                    
                    distance = 3
                }
                
                for secondIndex in allBeacons.indices {
                    if allBeacons[secondIndex].2.parseMajorMinor().minor == Int(truncating: beacons[index].minor) {
                        allBeacons[secondIndex].0 = distance
                        allBeacons[secondIndex].1 = beacons[index].accuracy
                        usedBeacons.insert(secondIndex)
                    }
                }
            }
            
            mapView.drawCurrentPosition = true
            mapView.findLocation(allBeacons)
        }
        else {
            mapView.findLocation(Array())
            mapView.drawCurrentPosition = false
        }
    }
    
  
    func updateDistance(_ distance: CLProximity) {
        UIView.animate(withDuration: 0.1, animations: {
            switch distance {
            case .unknown:
                self.mapView!.backgroundColor = #colorLiteral(red: 0.731109798, green: 0.6722516418, blue: 0.8137128949, alpha: 1)
            case .far:
                self.mapView!.backgroundColor = UIColor.red
            case .near:
                self.mapView!.backgroundColor = UIColor.orange
            case .immediate:
                self.mapView!.backgroundColor = UIColor.green
            }
        })
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                if !hamburgerMenuIsVisible {
                    leadingC.constant = 250
                    //this constant is NEGATIVE because we are moving it 150 points OUTWARD and that means -150
                    trailingC.constant = -250

                    //1
                    hamburgerMenuIsVisible = true
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                        self.view.layoutIfNeeded()
                    }) { (animationComplete) in
                        print("The animation is complete!")
                    }
                }
            case .left:
                if hamburgerMenuIsVisible {
                    leadingC.constant = 0
                    trailingC.constant = 0

                    //2
                    hamburgerMenuIsVisible = false
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                        self.view.layoutIfNeeded()
                    }) { (animationComplete) in
                        print("The animation is complete!")
                    }
                }
            default:
                break
                
            }
        }
    }
    
    
    func newSearchPoi (dismissController: Bool, fromRoomId: String, ToId: String) {
        if (dismissController){
            dismiss(animated: true, completion: nil)
            
            print ("dismissed")
        }
        mapView.currentRoom = nil
        mapView.nextRoom = nil
        mapView.pathVertexes = nil
        mapView.needNavigating = false
        mapView.needsPathBuild = false
        mapView.firstElvtr = nil
        mapView.secondElvtr = nil
        dirLabel.isHidden = true
        
        navPathRooms = []
    
        
       
        if fromRoomId != "" {
            buildPathToPoiWithoutNavigating (fromRoomId: fromRoomId, ToId: ToId)
            return
        }
        
        var finishPoi: Poi?
        
        //получаем, в какой комнате находится геопозиция
        guard let currentRoom = mapView.currLocInsideRoom() else {
            
//            let alert = UIAlertController(title: "Ошибка", message: "Сигнал потерян. Постройте маршрут заново", preferredStyle: .alert)
//            self.present(alert, animated: true, completion: nil)
//            let mainQueue = DispatchQueue.main
//            let deadline = DispatchTime.now() + .seconds(2)
//            mainQueue.asyncAfter(deadline: deadline) {
//                alert.dismiss(animated: true, completion: nil)
//            }
            return
        }
    
        
        for current in allPois {
            if current.id == ToId {
                finishPoi = current
            }
        }
        toPoiId = ToId
        
        guard let poiRoom = finishPoi?.roomsrelationship else {print ("newSearchPoi:: poi without a room - terminate"); return}
        
        if currentRoom.id == poiRoom.id { // выводим контроллер с уведомлением что поиск ведется в комнату в которой мы и так находимся
            let alert = UIAlertController(title: "Ошибка", message: "Конечная комната маршрута совпадает с текущей", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let mainQueue = DispatchQueue.main
            let deadline = DispatchTime.now() + .seconds(2)
            mainQueue.asyncAfter(deadline: deadline) {
                alert.dismiss(animated: true, completion: nil)
            }
            return
        }
        
        guard let finPoi = finishPoi else { print ("newSearch:: did not found finish poi"); return }
        
        // находим путь
        pathVertexes = graph.findShortestPathRunningDijkstra(start: currentRoom, finish: finPoi).1
        if pathVertexes.capacity==0 { print ("newSearch1:: path is empty"); return }
        mapView.needsPathBuild = true
        stopshowbutton.isHidden = false
        
        var room = self.pathVertexes[0].roomsrelationship!
        for pathVertex in pathVertexes {
            if pathVertex.roomsrelationship!.id != room.id {
                navPathRooms.append(room)
                room = pathVertex.roomsrelationship!
            }
        }
        navPathRooms.append (room)
        
        print ("вывод комнат на пути маршрута:")
        for room in navPathRooms {
            print (room.id)
        }
        
        if navPathRooms.capacity<2 {print ("newSearch:: only one room in route") ; interruptNavigating(); return}
        // теперь передадим комнаты в мап вью
        currRoomIndex = 0
        mapView.currentRoom = navPathRooms[currRoomIndex]
        
        //проверяем на лифт
        if navPathRooms[currRoomIndex+1].type == 4 {
            mapView.firstElvtr = navPathRooms[currRoomIndex+1]
            mapView.secondElvtr = navPathRooms[currRoomIndex+2]
            mapView.nextRoom = navPathRooms[currRoomIndex+3]
            dirLabel.text = String ("Проследуйте на лифте на \(navPathRooms[currRoomIndex+3].floorsrelationship!.name!)")
            dirLabel.isHidden = false
        } else {
            mapView.nextRoom = navPathRooms[currRoomIndex+1]
            dirLabel.text = String ("Следующая комната - темно-синяя")
            dirLabel.isHidden = false
        }
        mapView.pathVertexes = pathVertexes
        mapView.needNavigating = true
        
        mapView.centrateAroundCurrLoc()
        
    }
    
    func newSearch(dismissController: Bool, fromId: String, ToId: String) {
        if (dismissController){
            dismiss(animated: true, completion: nil)
        }
       
        
        
        mapView.currentRoom = nil
        mapView.nextRoom = nil
        mapView.pathVertexes = nil
        mapView.needNavigating = false
        mapView.needsPathBuild = false
        mapView.firstElvtr = nil
        mapView.secondElvtr = nil
        dirLabel.isHidden = true
        toPoiId = nil
        
       
        navPathRooms = []
        
        if fromId != "" {
            buildPathToRoomWithoutNavigating (fromId: fromId, toId: ToId)
            return
        }
        
        //иначе ищем комнату, в которой текущая локация находится
        var finishRoom: Rooms?
        
        //получаем, в какой комнате находится геопозиция
        guard let currentRoom = mapView.currLocInsideRoom() else {
                return
        }
        
        
        
        
        for current in allRooms {
            if current.id == ToId {
                finishRoom = current
            }
        }
        if currentRoom.id == finishRoom?.id { // выводим контроллер с уведомлением что поиск ведется в комнату в которой мы и так находимся
            let alert = UIAlertController(title: "Ошибка", message: "Конечная комната маршрута совпадает с текущей", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let mainQueue = DispatchQueue.main
            let deadline = DispatchTime.now() + .seconds(2)
            mainQueue.asyncAfter(deadline: deadline) {
                alert.dismiss(animated: true, completion: nil)
            }
            return
        }
        
        guard let finRoom = finishRoom else { print ("newSearch:: did not found finish room"); return }
        
        // находим путь
        pathVertexes = graph.findShortestPathRunningDijkstra(start: currentRoom, finish: finRoom).1
        if pathVertexes.capacity==0 { print ("newSearch1:: path is empty"); return }
        mapView.needsPathBuild = true
        stopshowbutton.isHidden = false
        
        // определяем комнаты в которых проходит маршрут
        
        var room = self.pathVertexes[0].roomsrelationship!
        for pathVertex in pathVertexes {
            if pathVertex.roomsrelationship!.id != room.id {
                navPathRooms.append(room)
                room = pathVertex.roomsrelationship!
            }
        }
        navPathRooms.append (room)
        
        print ("вывод комнат на пути маршрута:")
        for room in navPathRooms {
            print (room.id)
        }
        
        if navPathRooms.capacity<2 {print ("newSearch:: only one room in route") ; interruptNavigating(); return}
        // теперь передадим комнаты в мап вью
        currRoomIndex = 0
        mapView.currentRoom = navPathRooms[currRoomIndex]
        
        //проверяем на лифт
        if navPathRooms[currRoomIndex+1].type == 4 {
            mapView.firstElvtr = navPathRooms[currRoomIndex+1]
            mapView.secondElvtr = navPathRooms[currRoomIndex+2]
            mapView.nextRoom = navPathRooms[currRoomIndex+3]
            dirLabel.text = String ("Проследуйте на лифте на \(navPathRooms[currRoomIndex+3].floorsrelationship!.name!)")
            dirLabel.isHidden = false
        } else {
            mapView.nextRoom = navPathRooms[currRoomIndex+1]
            dirLabel.text = String ("Следующая комната - темно-синяя")
            dirLabel.isHidden = false
        }
        mapView.pathVertexes = pathVertexes
        mapView.needNavigating = true
    
        //сцентрироваться
        mapView.centrateAroundCurrLoc()
        
        
}
    func findDistanceFromRoomToRoom  (fromRoomId: String, toRoomId: String) -> Double {
        var startRoom: Rooms?
        var finishRoom: Rooms?
        for current in allRooms {
            if current.id == fromRoomId {
                startRoom = current
            }
            if current.id == toRoomId {
                finishRoom = current
            }
        }
        if let finRoom = finishRoom, let stRoom = startRoom  {
            if stRoom.id == finRoom.id {
                return 0
            }
            if let dist = graph.findShortestPathRunningDijkstra(start: stRoom, finish: finRoom).0 {
                return dist
            } else {
                return -1.0
            }
    } else
    {
        return -1.0
        }
        
    }
    
    func findDistanceFromRoomToPoi  (fromRoomId: String, toPoiId: String) -> Double {
        var startRoom: Rooms?
        var finishPoi: Poi?
        for current in allRooms {
            if current.id == fromRoomId {
                startRoom = current
            }
        }
        for current in allPois {
            if current.id == toPoiId {
                finishPoi = current
            }
        }
        if let finPoi = finishPoi, let stRoom = startRoom  {
            if stRoom.id == finPoi.roomsrelationship!.id {
                return 0
            }
            if let dist = graph.findShortestPathRunningDijkstra(start: stRoom, finish: finPoi).0 {
                return dist
            } else {
                return -1.0
            }
        } else
        {
            return -1.0
        }
    }
    
    func buildPathToRoomWithoutNavigating (fromId: String, toId: String){
        var startRoom: Rooms?
        var finishRoom: Rooms?
        for current in allRooms {
            if current.id == fromId {
                startRoom = current
            }
            if current.id == toId {
                finishRoom = current
            }
        }
        
        if finishRoom != nil && startRoom != nil {
            
            if startRoom!.id == finishRoom!.id { // выводим контроллер с уведомлением что поиск ведется в комнату в которой мы и так находимся
                let alert = UIAlertController(title: "Ошибка", message: "Конечная комната маршрута совпадает с текущей", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                let mainQueue = DispatchQueue.main
                let deadline = DispatchTime.now() + .seconds(2)
                mainQueue.asyncAfter(deadline: deadline) {
                    alert.dismiss(animated: true, completion: nil)
                }
                return
            }
            mapView.pathVertexes = graph.findShortestPathRunningDijkstra(start: startRoom!, finish: finishRoom!).1
            mapView.needsPathBuild = true
            stopshowbutton.isHidden = false
        }
        else {
            stopshowbutton.isHidden = true
            mapView.needsPathBuild = false
        }
    }
    
    func buildPathToPoiWithoutNavigating (fromRoomId: String, ToId: String){
        var startRoom: Rooms?
        var finishPoi: Poi?
        
        for current in allRooms {
            if current.id == fromRoomId {
                startRoom = current
            }
        }
        for current in allPois {
            if current.id == ToId {
                finishPoi = current
            }
        }
        guard let poiRoom = finishPoi?.roomsrelationship else {print ("newSearchPoi:: poi without a room - terminate"); return}
        
        if finishPoi != nil && startRoom != nil {
            if startRoom!.id == poiRoom.id { // выводим контроллер с уведомлением что поиск ведется в комнату в которой мы и так находимся
                let alert = UIAlertController(title: "Ошибка", message: "Конечная комната маршрута совпадает с текущей", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                let mainQueue = DispatchQueue.main
                let deadline = DispatchTime.now() + .seconds(2)
                mainQueue.asyncAfter(deadline: deadline) {
                    alert.dismiss(animated: true, completion: nil)
                }
                return
            }
            mapView.pathVertexes = graph.findShortestPathRunningDijkstra(start: startRoom!, finish: finishPoi!).1
            mapView.needsPathBuild = true
            stopshowbutton.isHidden = false
        }
        else {
            stopshowbutton.isHidden = true
            mapView.needsPathBuild = false
        }
        
        
    }
    
    
    
    func continueNavigating() {
        guard let nowInRoom = mapView.currLocInsideRoom() else { print ("continueNavigating:: currLocInsideRoom returned nil"); return }
        
        print (navPathRooms)
        
        if ( navPathRooms[currRoomIndex] == nowInRoom ) { return } // комната не изменилась
        
        mapView.firstElvtr = nil
        mapView.secondElvtr = nil
        dirLabel.isHidden = true
       
        if (currRoomIndex+1 >= navPathRooms.capacity) { print ("continueNavigating::no such room in rooms array"); return }
        
        var step = navPathRooms[currRoomIndex + 1].type == 4 ? 3 : 1  // если след комната - лифт, то шаг +3, иначе +1
        
        
        if  navPathRooms[currRoomIndex + step] == nowInRoom  // перешли в нужную комнату
        {
            //смещаем индекс в массиве комнат
            
            currRoomIndex += step
            
            //if она последняя - вызвать завершающую функцию
            if let last = navPathRooms.last, last == nowInRoom {
                endNavigating()
                return
            }
            
            
            
            
            mapView.currentRoom = navPathRooms[currRoomIndex]
            //проверяем на лифт
            if navPathRooms[currRoomIndex+1].type == 4 {
                mapView.firstElvtr = navPathRooms[currRoomIndex+1]
                mapView.secondElvtr = navPathRooms[currRoomIndex+2]
                dirLabel.text = String ("Проследуйте на лифте на \(navPathRooms[currRoomIndex+3].floorsrelationship!.name!)")
                dirLabel.isHidden = false
                mapView.nextRoom = navPathRooms[currRoomIndex+3]
                
            } else {
                mapView.nextRoom = navPathRooms[currRoomIndex+1]
            }
            
            //удаляем вертексы во всех комнатах до текущей
            var cutIndex = 0
            for vertex in pathVertexes {
                if vertex.roomsrelationship!.id != mapView.currentRoom?.id {
                    cutIndex+=1
                    continue
                }
                break
            }
            pathVertexes.removeSubrange(0..<cutIndex)
            mapView.pathVertexes = pathVertexes
            mapView.needNavigating = true
            
        } else {
            
            // ушли в другую комнату
            //вывести алерт "маршрут перестроен"
            mapView.needNavigating = false
            let alert = UIAlertController(title: "Вы ушли не туда", message: "Маршрут перестраивается", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            
            let mainQueue = DispatchQueue.main
            let deadline = DispatchTime.now() + .seconds(2)
            mainQueue.asyncAfter(deadline: deadline) {
                alert.dismiss(animated: true, completion: nil)
                if let poiId = self.toPoiId {
                    
                    self.newSearchPoi(dismissController: false, fromRoomId: "", ToId: poiId)
                } else {
                    
                    self.newSearch(dismissController: false, fromId: "", ToId: self.navPathRooms.last?.id ?? " ")
                }
            }
        }
    }
    
    
    //когда вошли в последнюю комнату маршрута
    func endNavigating (){
         mapView.needNavigating = false
        
        let alert = UIAlertController(title: "Вы достигли пункта назначения", message: "", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        let mainQueue = DispatchQueue.main
        let deadline = DispatchTime.now() + .seconds(2)
        mainQueue.asyncAfter(deadline: deadline) {
            alert.dismiss(animated: true, completion: nil)
        }
        
        
        mapView.currentRoom = nil
        mapView.nextRoom = nil
        mapView.firstElvtr = nil
        mapView.secondElvtr = nil
        dirLabel.isHidden = true
        mapView.pathVertexes = nil
        mapView.needNavigating = false
        mapView.needsPathBuild = false
        toPoiId = nil
        
    }
    
    //прервать. К примеру, при нажатии кнопки с крестиком
    func interruptNavigating(){
        mapView.currentRoom = nil
        mapView.nextRoom = nil
        mapView.firstElvtr = nil
        mapView.secondElvtr = nil
        dirLabel.isHidden = true
        mapView.pathVertexes = nil
        mapView.needNavigating = false
        mapView.needsPathBuild = false
        toPoiId = nil
    }

    
    func tryBuildingPath(roomId: String) {
        let buildPathAction = UIAlertAction(title: "Да",
                                            style: .destructive) { (action) in
                                                self.newSearch(dismissController: false, fromId: "", ToId: roomId)
        }
        let cancelAction = UIAlertAction(title: "Отмена",
                                         style: .cancel) { (action) in
            return
        }
        
        let alert = UIAlertController(title: "Построить маршрут в эту комнату?",
                                      message: "",
                                      preferredStyle: .actionSheet)
        alert.addAction(buildPathAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func changeFloorLabel (floorNum: Int)
    {
        currentFloorLabel.text = String("Этаж: \(floorNum)")
    }
    
    func setCentrateButtonAvailiable(availiable: Bool) {
        centrateButton.isEnabled = availiable
    }
    
    // прикрепляем делегат, передаем данные о доступности текущей геопозиции поисковому контроллеру
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? FindRouteViewController
        if let newBirthdayController = controller {
            
            newBirthdayController.currentRoom = mapView.currLocInsideRoom()
            newBirthdayController.delegate = self
        }
        }
        

}
    //////////
    


