//
//  MapView.swift
//  indoor navigation a

import UIKit
import CoreLocation

class MapView: UIView {
    
    var roomTagDict: [String : Int] = [:]
    var poiTagDict: [String : Int] = [:]
    
    var arrowImage =  UIImage(named: "arrow.png")!
    
    var needNavigating = false { didSet { setNeedsDisplay() } }
    
    var currentRoom: Rooms? = nil
    var nextRoom: Rooms? = nil
    var firstElvtr: Rooms? = nil
    var secondElvtr:  Rooms? = nil
    
    //текущий этаж по данным
    var currentFloorLoc: Floors? = nil {  didSet {
        changeFloor();
        
        }  }

    var currentBeaconName: String?
    var newBeaconName: String?
    var changeBeaconCounter = 0
    
    @IBOutlet weak var roomlabel: UILabel!
    

    weak var finderInsideDelegate: FinderInsideDelegate?

    var updateMapView = 0 { didSet { setNeedsDisplay() } }
    private var mapScale: CGFloat = 1.0 { didSet { setNeedsDisplay() } }
    private var mapOffsetX: CGFloat = 0.0 { didSet {
        setMapOffsets()
        setNeedsDisplay() } }
    private var mapOffsetY: CGFloat = 0.0 { didSet {
        setMapOffsets()
        setNeedsDisplay() } }
    
    var needsPathBuild = false { didSet { setNeedsDisplay() } }
    var pathVertexes: [Vertex]? = nil { didSet { setNeedsDisplay() } }
    
    var currentFloor: Floors? = nil { didSet {
        setNeedsDisplay()
        if let currF = currentFloor{
            if (currF.name! == "1 этаж") {
                finderInsideDelegate?.changeFloorLabel (floorNum: 1)
            } else {
                finderInsideDelegate?.changeFloorLabel (floorNum: 2)
            }
        }
         } }
    
   
    var drawCurrentPosition = false { didSet {
        setNeedsDisplay()
        }
    }
    
    var currentPosition: CGPoint? = nil { didSet {
        if needNavigating{
            finderInsideDelegate?.continueNavigating()
        }
        if currentPosition == nil {
            finderInsideDelegate?.setCentrateButtonAvailiable(availiable: false)
        } else {
            finderInsideDelegate?.setCentrateButtonAvailiable(availiable: true)
        }
        setNeedsDisplay()
        }
    }
    
    let verticalAxisHeading: CLLocationDirection = 134
    var arrowHeading: CLLocationDirection? = nil { didSet { setNeedsDisplay() } }
    
    
    private var minX = 0.0
    private var maxX = 0.0
    private var minY = 0.0
    private var maxY = 0.0
    private var ratioX = 0.0
    private var ratioY = 0.0
    

 
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // #3
    public convenience init() {
        self.init(frame: .zero)
    }
    
    private func setMapOffsets(){
        if mapOffsetX > 400.0*mapScale {
            mapOffsetX = 400.0*mapScale
        }
        if mapOffsetX < -600.0*mapScale {
            mapOffsetX = -600.0*mapScale
        }
        if mapOffsetY > 200.0*mapScale  {
            mapOffsetY = 200.0*mapScale
        }
        if mapOffsetY < -600.0*mapScale {
            mapOffsetY = -600.0*mapScale
        }
    }
    
    func centrateAroundCurrLoc () {
        var floorFlag = false
        if let currFloorLoc = currentFloorLoc, let currFloor = currentFloor {
            if currFloorLoc != currFloor {
                currentFloor = currentFloorLoc
                floorFlag = true
            }
        }
        
        let magic = min(bounds.width, bounds.height)
        ///////////////////////
        minX = Double.infinity
        maxX = -Double.infinity
        minY = Double.infinity
        maxY = -Double.infinity
        
        for current in currentFloor!.roomsrelationship! {
            for point in (current as! Rooms).parsePolygon()! {
                minX = min(minX, point.x)
                maxX = max(maxX, point.x)
                
                minY = min(minY, point.y)
                maxY = max(maxY, point.y)
            }
        }
        
        ratioX = (Double(magic) * 0.98) / (maxX - minX)
        ratioY = (Double(magic) * 0.98) / (maxY - minY)
        
        ratioX = min (ratioX,ratioY)
        ratioY = ratioX
        ////////////////////////
        
        //вычисляем координаты точки во вью
        guard let dot = currentPosition else {return}
        
        let newMapScale = CGFloat(2.0)
        
        let dispDot = dot.offset(dx: -minX, dy: -minY).adjustCoordinates(multiplierX: ratioX, multiplierY: ratioY).offset(dx: Double(magic) * 0.01, dy: Double(magic) * 0.01).adjustCoordinates(multiplierX: Double(newMapScale), multiplierY: Double(newMapScale)).offset(dx: -Double(mapOffsetX), dy: -Double(mapOffsetY))
        
        let viewCenter = CGPoint(x: bounds.width/2, y: bounds.height/2)
        
        print ("disp dot: \(dispDot)")
        print ("viewCenter: \(viewCenter)")
        
        //наша точка должна стать центром
        let dX = viewCenter.x - dispDot.x
        let dY = viewCenter.y - dispDot.y
        
        mapOffsetY -= dY
        mapOffsetX -= dX
        
        mapScale = newMapScale
        
     
    }
    
    private func setupView() {
        // добавляем картинки для всех комнат
        var viewImg: UIImage?
        var roomIconView: UIImageView
        var tag = 2 // стартовый тэг
        for room in allRooms{
            viewImg = nil
            switch room.type {
            case 2: //manToilet
                viewImg = UIImage(named: "manToilet.png")!
            case 3: //womanToilet
                 viewImg = UIImage(named: "womenToilet.png")!
            case 4: //elevator
                 viewImg = UIImage(named: "elevator.png")!
            default:
                break
            }
            if let viewImg = viewImg{
                print ("roomWithImg")
                print (room.id)
                roomIconView = UIImageView(image: viewImg)
                roomIconView.tag = tag
                roomTagDict[room.id] = tag
                tag += 1
                roomIconView.frame = CGRect(x:0, y: 0, width: 1, height: 1)
                roomIconView.isHidden = true
                self.addSubview(roomIconView)
        }
        }
        for poi in allPois{
            viewImg = nil
            print ("poi type:")
            print (poi.type)
            switch poi.type {
            case 1:
                viewImg = UIImage(named: "drink.png")!
            case 2:
                viewImg = UIImage(named: "sitplace.png")!
            case 3:
                viewImg = UIImage(named: "atm.png")!
            default:
                break
            }
            if let viewImg = viewImg{
                print ("poiWithImg")
                print (poi.id)
                roomIconView = UIImageView(image: viewImg)
                roomIconView.tag = tag
                poiTagDict[poi.id] = tag
                tag += 1
                roomIconView.frame = CGRect(x:0, y: 0, width: 1, height: 1)
                roomIconView.isHidden = true
                self.addSubview(roomIconView)
            }
        }
    }
    
    
    private func hideLabels() {
        for (_, tag) in roomTagDict {
            self.viewWithTag(tag)?.isHidden = true
        }
        for (_, tag) in poiTagDict {
            self.viewWithTag(tag)?.isHidden = true
        }
    }
    
    @objc func searchFromThisRoom(longPressRecognizer recognizer: UILongPressGestureRecognizer){
        switch recognizer.state{
        case .began:
            if currentPosition == nil {return}
            guard let room = tappedInsideRoom( point: recognizer.location(in: self) ) else {return}
            finderInsideDelegate?.tryBuildingPath(roomId: room.id)
        default:
            break
        }
    }
    
    @objc func adjustMapScale(byHandlingGestureRecognizer recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .changed, .ended:
            mapScale *= recognizer.scale
            recognizer.scale = 1.0
            if mapScale < 0.75 {
                mapScale = 0.75
            }
            if mapScale > 10 {
                mapScale = 10
            }
        default:
            break
        }
        print ("mapScale")
        print (mapScale)
    }
    
    @objc func getTappedRectangle(UsingHandlingGestureRecognizer recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            let magic = min(bounds.width, bounds.height)
            
            var localPolygon: Polygon?
            for rectangle in allRooms {
                if rectangle.floorsrelationship != currentFloor {
                    continue
                }
                
                let figure = Polygon(points: rectangle.parsePolygon() ?? [])
                
                if figure.points.count == 0 {
                    continue
                }
                
                figure.offset(dx: -minX, dy: -minY)
                figure.adjustCoordinates(multiplierX: ratioX, multiplierY: ratioY)
                figure.offset(dx: Double(magic) * 0.01, dy: Double(magic) * 0.01)
                figure.adjustCoordinates(multiplierX: Double(mapScale), multiplierY: Double(mapScale))
                figure.offset(dx: -Double(mapOffsetX), dy: -Double(mapOffsetY))
                
                let point = recognizer.location(in: recognizer.view)
                //point = point.offset(dx: -minX, dy: -minY).adjustCoordinates(multiplierX: ratioX, multiplierY: ratioY).offset(dx: Double(magic) * 0.01, dy: Double(magic) * 0.01).adjustCoordinates(multiplierX: Double(mapScale), multiplierY: Double(mapScale)).offset(dx: -Double(mapOffsetX), dy: -Double(mapOffsetY))
                
                if figure.isInside(point: (x: Double(point.x), y: Double(point.y))) {
                    if localPolygon == nil {
                        roomlabel.text = rectangle.name
                        localPolygon = figure
                    }
                    else {
                        if localPolygon!.square() > figure.square() {
                            roomlabel.text = rectangle.name
                            localPolygon = figure
                        }
                    }
                }
      
            }
            
            print("@@@@@@@@@@@@@@@")
            
           
            if localPolygon == nil {
                roomlabel.text = nil
            }
        default:
            break
        }
        
    }
    
    
    @objc func adjustMapOffset(byHandlingGestureRecognizer recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            mapOffsetX += -recognizer.translation(in: recognizer.view).x
            mapOffsetY += -recognizer.translation(in: recognizer.view).y
            recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
           
        case .changed:
            mapOffsetX += -recognizer.translation(in: recognizer.view).x
            mapOffsetY += -recognizer.translation(in: recognizer.view).y
            recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
            print ("Offset: ")
            print (mapOffsetX)
            print (mapOffsetY)
        default:
            break
        }
    }
    
    //определяет в какой комнате находится текущая локация
    func currLocInsideRoom () -> Rooms? {
       // let magic = min(bounds.width, bounds.height)
        var localPolygon: Polygon?
        var localRoom: Rooms?
        
        guard let currentPos = currentPosition else {print ("currLocInsideRoom:: no current position loc"); return nil}
        
        for room in allRooms {
            if room.floorsrelationship != currentFloorLoc {
                continue
            }
            
            let figure = Polygon(points: room.parsePolygon() ?? [])
            
            if figure.points.count == 0 {
                continue
            }
            
            
            if figure.isInside(point: (x: Double(currentPos.x), y: Double(currentPos.y))) {
                if localRoom == nil {
                    localPolygon = figure
                    localRoom = room
                }
                else {
                    if localPolygon!.square() > figure.square() {
                        localPolygon = figure
                        localRoom = room
                    }
                }
            }
        }
        return localRoom
        
    }
    

    private func tappedInsideRoom (point:CGPoint) -> Rooms? {
         let magic = min(bounds.width, bounds.height)
        var localPolygon: Polygon?
        var localRoom: Rooms?
        
        
        
        for room in allRooms {
            if room.floorsrelationship != currentFloor {
                continue
            }
            
            let figure = Polygon(points: room.parsePolygon() ?? [])
            
            if figure.points.count == 0 {
                continue
            }
            
                        figure.offset(dx: -minX, dy: -minY)
                        figure.adjustCoordinates(multiplierX: ratioX, multiplierY: ratioY)
                        figure.offset(dx: Double(magic) * 0.01, dy: Double(magic) * 0.01)
                        figure.adjustCoordinates(multiplierX: Double(mapScale), multiplierY: Double(mapScale))
                        figure.offset(dx: -Double(mapOffsetX), dy: -Double(mapOffsetY))
            
            
           
            
            if figure.isInside(point: (x: Double(point.x), y: Double(point.y))) {
                if localRoom == nil {
                    localPolygon = figure
                    localRoom = room
                }
                else {
                    if localPolygon!.square() > figure.square() {
                        localPolygon = figure
                        localRoom = room
                    }
                }
            }
        }
        print ("комната")
        
        if localRoom?.type == 4 {// если это лифт
            return nil
        }
        return localRoom
        
    }
    
    // эта функция обнаруживает текущее местоположение по биконам
    func findLocation(_ beacons: [(proximity : Int, accuracy: Double, item: Beacons)]) {
        var array = beacons.sorted(by: { $0.proximity < $1.proximity })
        

    
    
        
        var bestBeacon: Beacons?
        if (array.capacity>0){ // массив пришел не пустым (приходит пустым, если ни одного бикона в зоне действия
            if (array[0].proximity != 3) {// хоть один нашелся
            //посчитаем сколько есть биконов с меткой как у первого
                var countBestProx = 0
                for current in array {
                    if current.proximity != array[0].proximity { break }
                    countBestProx += 1
                }
                let slice = array[0..<countBestProx]
                
                let sortedSlice = slice.sorted(by: { $0.accuracy < $1.accuracy })
                bestBeacon = sortedSlice[0].item
            }
        }
        if bestBeacon == nil {
            
//            roomlabel.text = "nil"
            
            if newBeaconName != nil { // впервые пропал сигнал
                newBeaconName = nil
                changeBeaconCounter = 1
                return
            } else { // не в первый раз пропал сигнал
                changeBeaconCounter += 1
            }
            if changeBeaconCounter > 20 { // если новый бикон уже 20 раз пуст
                currentBeaconName = nil
                currentFloorLoc = nil
                currentPosition = nil
                changeBeaconCounter = 1
                newBeaconName = nil
                return
            }
        }
        
        
        
        guard let bestBeac = bestBeacon else {return}
        
        
        if currentBeaconName == nil{ // бикон не был назначен (первый проход)
            guard let newCoordinates = bestBeac.parseCoordinates() else {return}
            currentPosition = CGPoint(x:newCoordinates.x, y:newCoordinates.y)
            currentFloorLoc = bestBeac.roomsrelationship!.floorsrelationship!
            currentBeaconName = bestBeac.name!
            changeBeaconCounter = 1
            return
        }
        
        
        if bestBeac.name! == currentBeaconName { return } // бикон не изменился
        
        
        
        if newBeaconName == nil { //попался новый бикон, но еще не сохранялся как "новый" (первый проход)
            newBeaconName = bestBeac.name!
            changeBeaconCounter = 1
            return
        }
        
        guard let newB = newBeaconName else { return }
        
        if bestBeac.name! == newB { // вновь попался тот же самый
            changeBeaconCounter += 1
        } else { //попался другой "новый бикон"
            newBeaconName = bestBeac.name!
            changeBeaconCounter = 1
            return
        }
        
        if changeBeaconCounter > 2
        { // накопилось достаточно одного и того же нового бикона
            currentBeaconName = bestBeac.name!
            currentFloorLoc = bestBeac.roomsrelationship!.floorsrelationship!
            let coord = bestBeac.parseCoordinates()!
            currentPosition = CGPoint(x:coord.x,y:coord.y)
            changeBeaconCounter = 1
            newBeaconName = nil
            return
        }
        
    }
    
    private func drawRooms1(rooms: [Rooms]) {
        let magic = min(bounds.width, bounds.height)
        
        var figures =  [Polygon]()
        for room in rooms {
            figures.append(Polygon(points: room.parsePolygon()!))
        }
        
        for index in figures.indices {
            
            figures[index].offset(dx: -minX, dy: -minY)
            figures[index].adjustCoordinates(multiplierX: ratioX, multiplierY: ratioY)
            figures[index].offset(dx: Double(magic) * 0.01, dy: Double(magic) * 0.01)
            figures[index].adjustCoordinates(multiplierX: Double(mapScale), multiplierY: Double(mapScale))
            figures[index].offset(dx: -Double(mapOffsetX), dy: -Double(mapOffsetY))
           
        }
        
        for current in figures {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: current.points[0].x, y: current.points[0].y))
            for index in current.points.indices {
                path.addLine(to: CGPoint(x: current.points[index].x, y: current.points[index].y))
            }
            path.close()
            
            path.lineWidth = CGFloat(3/2.0) * mapScale
            #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1).setFill()
            UIColor.black.setStroke()
            path.fill()
            path.stroke()
        }
        print ("drawRoomsWorked")
    }
    
    private func drawRooms(rooms: [Rooms]) {
        
         let magic = min(bounds.width, bounds.height)
        
        for room in rooms {
            #colorLiteral(red: 0.7729272246, green: 0.90136832, blue: 0.9391201735, alpha: 0.8963505993).setFill()
            if let current = currentRoom, room.id == current.id {
                #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 0.8407801798).setFill()
            }
            if let next = nextRoom, room.id == next.id {
                 #colorLiteral(red: 0.3936805499, green: 0.6554496974, blue: 0.9733553853, alpha: 1).setFill()
            }
            
            if let elvtr1 = firstElvtr, let elvtr2 = secondElvtr, (room.id == elvtr1.id || room.id == elvtr2.id) {
                 #colorLiteral(red: 0.731109798, green: 0.6722516418, blue: 0.8137128949, alpha: 1).setFill()
            }
            
            let figure = Polygon(points: room.parsePolygon()!)
            figure.offset(dx: -minX, dy: -minY)
            figure.adjustCoordinates(multiplierX: ratioX, multiplierY: ratioY)
            figure.offset(dx: Double(magic) * 0.01, dy: Double(magic) * 0.01)
            figure.adjustCoordinates(multiplierX: Double(mapScale), multiplierY: Double(mapScale))
            figure.offset(dx: -Double(mapOffsetX), dy: -Double(mapOffsetY))
            
            //рисуем комнаты
            let path = UIBezierPath()
            path.move(to: CGPoint(x: figure.points[0].x, y: figure.points[0].y))
            for index in figure.points.indices {
                path.addLine(to: CGPoint(x: figure.points[index].x, y: figure.points[index].y))
            }
            path.close()
            
            path.lineWidth = CGFloat(3/2.0) * mapScale
            
            #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1).setStroke()
            path.fill()
            path.stroke()
            
            let roomCenter = figure.findCenter()
            // добавим вью по центру комнаты с лейблом
            if  roomTagDict[room.id] != nil {
                if let foundView = self.viewWithTag(roomTagDict[room.id]!) {
                    let imgMultiplier = 20.0
                    let size = CGFloat(imgMultiplier)*mapScale
                    foundView.frame = CGRect(x: roomCenter.x - size/2, y: roomCenter.y - size/2, width: size, height: size)
                    foundView.isHidden = false
                }
            }
            
            //добавим номера аудиторий
            if room.type == 1 { // если это аудитория
                let numLabel = room.name! as NSString
                let lblMultiplier = 27.0
                let size = CGFloat(lblMultiplier)*mapScale
                let rectToDraw = CGRect(x: roomCenter.x - size/3, y: roomCenter.y - size/4, width: size, height: size/2)
                
                
                numLabel.draw(with: rectToDraw, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [.font: UIFont(name: "Helvetica", size: 12*mapScale)], context: nil)
            }
            
        }
    }
    
    private func drawExits(exits: [Edge]) {
        let magic = min(bounds.width, bounds.height)
        
        var exitsLines = [Polygon]()
        for exit in exits {
            if let currentExit = exit.parseDoorsCoordinates() {
                if let from = exit.vertexfromrelationship, let to = exit.vertextorelationship {
                    if let fromRoom = from.roomsrelationship, let toRoom = to.roomsrelationship {
                        if fromRoom.floorsrelationship == currentFloor, toRoom.floorsrelationship == currentFloor {
                            exitsLines.append(Polygon(points: currentExit))
                        }
                    }
                }
            }
        }
        
        for index in exitsLines.indices {
            exitsLines[index].offset(dx: -minX, dy: -minY)
            exitsLines[index].adjustCoordinates(multiplierX: ratioX, multiplierY: ratioY)
            exitsLines[index].offset(dx: Double(magic) * 0.01, dy: Double(magic) * 0.01)
            exitsLines[index].adjustCoordinates(multiplierX: Double(mapScale), multiplierY: Double(mapScale))
            exitsLines[index].offset(dx: -Double(mapOffsetX), dy: -Double(mapOffsetY))
        }
        
        for current in exitsLines {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: current.points[0].x, y: current.points[0].y))
            path.addLine(to: CGPoint(x: current.points[1].x, y: current.points[1].y))
            
            path.lineWidth = CGFloat(1.0) * mapScale
            UIColor.white.setStroke()
            path.stroke()
        }
    }
    
    // эта функция прорисовывает точки
    private func drawPoints(vertexes: [CGPoint]) -> [CGPoint] {
        let magic = min(bounds.width, bounds.height)
        
        var secondVertexesArray = vertexes
         for index in vertexes.indices {
            let newVertexValue: CGPoint = secondVertexesArray[index].offset(dx: -minX, dy: -minY).adjustCoordinates(multiplierX: ratioX, multiplierY: ratioY).offset(dx: Double(magic) * 0.01, dy: Double(magic) * 0.01).adjustCoordinates(multiplierX: Double(mapScale), multiplierY: Double(mapScale)).offset(dx: -Double(mapOffsetX), dy: -Double(mapOffsetY))
             secondVertexesArray[index] = newVertexValue
         }
        
        
        for current in secondVertexesArray {
            
            let path = UIBezierPath() // путь - прямая, соединенная точками

                path.addArc(withCenter: current, radius: CGFloat(1) * mapScale, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
                path.close()
                
                path.lineWidth = CGFloat(0.5) * mapScale
                UIColor.blue.setFill()
                UIColor.black.setStroke()
                path.fill()
                path.stroke()
        }
        
        return secondVertexesArray
    }
    
    
    private func drawPath(vertexes: [CGPoint]?) {
        if vertexes == nil {
            return
        }
        if (vertexes!.count == 0) {
            return
        }
        
        let magic = min(bounds.width, bounds.height)
        
        var secondVertexesArray = vertexes!
        for index in vertexes!.indices {
            let newVertexValue: CGPoint = secondVertexesArray[index].offset(dx: -minX, dy: -minY).adjustCoordinates(multiplierX: ratioX, multiplierY: ratioY).offset(dx: Double(magic) * 0.01, dy: Double(magic) * 0.01).adjustCoordinates(multiplierX: Double(mapScale), multiplierY: Double(mapScale)).offset(dx: -Double(mapOffsetX), dy: -Double(mapOffsetY))
            secondVertexesArray[index] = newVertexValue
        }
        
        let path = UIBezierPath()
        let start = secondVertexesArray[0]
        path.move(to: CGPoint(x: start.x, y: start.y))
        
        var previousVertex = start
        for current in secondVertexesArray {
            path.addLine(to: CGPoint(x: current.x, y: current.y))
            
            var vector = (x: Double(current.x - previousVertex.x), y: Double(current.y - previousVertex.y))
            let vectorLength = distance((x: Double(current.x), y: Double(current.y)), (x: Double(previousVertex.x), y: Double(previousVertex.y)))
            
            vector.x /= vectorLength
            vector.y /= vectorLength
            
            previousVertex = current
            
            let point = (x: Double(current.x) - vector.x * vectorLength / 5, y: Double(current.y) - vector.y * vectorLength / 5)
            
            let arrow = UIBezierPath()
            arrow.move(to: CGPoint(x: point.x - vectorLength / 15 * vector.y, y: point.y + vectorLength / 15 * vector.x))
            arrow.addLine(to: current)
            arrow.addLine(to: CGPoint(x: point.x + vectorLength / 15 * vector.y, y: point.y - vectorLength / 15 * vector.x))
            arrow.close()
            
            arrow.lineWidth = 1.0
            UIColor.blue.setFill()
            arrow.fill()
        }
        
        path.lineWidth = CGFloat(0.6) * mapScale
        UIColor.blue.setStroke()
        path.stroke()
    }
    
    //тут отрисовывается вся карта
    override func draw(_ rect: CGRect) {
       
       
        
        if currentFloor == nil {
            return
        }
        
        hideLabels()
        
        minX = Double.infinity
        maxX = -Double.infinity
        minY = Double.infinity
        maxY = -Double.infinity
        
        for current in currentFloor!.roomsrelationship! {
            for point in (current as! Rooms).parsePolygon()! {
                minX = min(minX, point.x)
                maxX = max(maxX, point.x)
            
                minY = min(minY, point.y)
                maxY = max(maxY, point.y)
            }
        }
        
        let magic = min(bounds.width, bounds.height)
        
        
        
        ratioX = (Double(magic) * 0.98) / (maxX - minX)
        ratioY = (Double(magic) * 0.98) / (maxY - minY)
        
        ratioX = min (ratioX,ratioY)
        ratioY = ratioX
        
       
        var rooms =  [Rooms]()
        
        
        
        for current in currentFloor!.roomsrelationship! {
            if let room = current as? Rooms {
                rooms.append(room)
            }
        }
        
        
        drawRooms(rooms: rooms)
        
        var pois =  [Poi]()
        for poi in allPois {
            guard let currentFloor = currentFloor else {return}
            if let rr = poi.roomsrelationship{
                if rr.floorsrelationship!.id == currentFloor.id {
                    pois.append (poi)
                }
            }
        }
        
        drawPois(pois: pois)
        
        drawExits(exits: allEdges)
        
        var vertexes = [CGPoint]()
        
//        вывод всех вершин
//        for current in allEdges {
//            if let vertex = current.vertexfromrelationship {
//                if let room = vertex.roomsrelationship {
//                    if room.floorsrelationship == currentFloor, let point = vertex.parseCoordinates() {
//                        vertexes.append(CGPoint(x: point.x, y: point.y))
//                    }
//                }
//            }
//            if let vertex = current.vertextorelationship {
//                if let room = vertex.roomsrelationship {
//                    if room.floorsrelationship == currentFloor, let point = vertex.parseCoordinates() {
//                        vertexes.append(CGPoint(x: point.x, y: point.y))
//                    }
//                }
//            }
//        }
        
        // вывод всех вершин
        
        drawPosition ()
        
        
        vertexes = drawPoints(vertexes: vertexes)
        
        /*
         map is drawn
        */
        
        if needsPathBuild {
            vertexes.removeAll()
            if pathVertexes == nil {
                return
            }
            if pathVertexes!.count == 0 {
                return
            }
            
            for current in pathVertexes! {
                if let room = current.roomsrelationship {
                    if room.floorsrelationship == currentFloor {
                        if let point = current.parseCoordinates() {
                            vertexes.append(CGPoint(x: point.x, y: point.y))
                        }
                    }
                }
            }
          
                
            drawPath(vertexes: vertexes)
        
        }
       
            
        }
    
    private func drawPois (pois: [Poi]){
        let magic = min(bounds.width, bounds.height)
        for poi in pois {
           
            
            if  poiTagDict[poi.id] != nil {
                if let foundView = self.viewWithTag(poiTagDict[poi.id]!) {
                    var poiCoord = CGPoint (x: poi.parseCoordinates()!.x, y: poi.parseCoordinates()!.y)
                    
                    poiCoord = poiCoord.offset(dx: -minX, dy: -minY).adjustCoordinates(multiplierX: ratioX, multiplierY: ratioY).offset(dx: Double(magic) * 0.01, dy: Double(magic) * 0.01).adjustCoordinates(multiplierX: Double(mapScale), multiplierY: Double(mapScale)).offset(dx: -Double(mapOffsetX), dy: -Double(mapOffsetY))
                
                    
                    let poiMultiplier = 15.0
                    let size = CGFloat(poiMultiplier)*mapScale
                    foundView.frame = CGRect(x: poiCoord.x - size/2, y: poiCoord.y - size/2, width: size, height: size)
                    foundView.isHidden = false
                }
            }
        }
    }
    
    // текущая позиция
    func drawPosition(){
        let magic = min(bounds.width, bounds.height)
        guard let arrowView = self.viewWithTag(1) as? UIImageView else { return }
        
        if let position = currentPosition, currentFloor == currentFloorLoc { // позиция отрисовывается только тогда, когда навигационный этаж совпадает с отображаемым
            drawCurrentPosition = true
            
            
            
            //повернуть на градус
            let arrowAngle = arrowHeading ?? 90
            arrowView.image! = arrowImage.rotate(radians: CGFloat(arrowAngle) * .pi / 180)
        
            let newCurrentPos: CGPoint = position.offset(dx: -minX, dy: -minY).adjustCoordinates(multiplierX: ratioX, multiplierY: ratioY).offset(dx: Double(magic) * 0.01, dy: Double(magic) * 0.01).adjustCoordinates(multiplierX: Double(mapScale), multiplierY: Double(mapScale)).offset(dx: -Double(mapOffsetX), dy: -Double(mapOffsetY))
            
            let arrowMultiplier = 15.0
            let size = CGFloat(arrowMultiplier)*mapScale
            
            arrowView.frame = CGRect(x: newCurrentPos.x - size/2, y: newCurrentPos.y - size/2, width: size, height: size)
            
            arrowView.isHidden = false
        }
        else {
            
            arrowView.isHidden = true
            drawCurrentPosition = false
        }
        
        
        
    }
   
    func changeFloor(){
        if let fl = currentFloorLoc{
            if currentFloor != fl {
                currentFloor = fl
                centrateAroundCurrLoc()
            }
        }
    }
    
}






extension CGPoint {
    func offset(dx: Double, dy: Double) -> CGPoint {
        let newX = x + CGFloat(dx)
        let newY = y + CGFloat(dy)
        return CGPoint(x: newX, y: newY)
    }
    
    func adjustCoordinates(multiplierX: Double, multiplierY: Double) -> CGPoint {
        let newX = x * CGFloat(multiplierX)
        let newY = y * CGFloat(multiplierY)
        return CGPoint(x: newX, y: newY)
    }
}

extension Polygon {
    func offset(dx: Double, dy: Double) {
        for index in 0 ..< points.count {
            points[index].x += dx
            points[index].y += dy
        }
    }
    
    func adjustCoordinates(multiplierX: Double, multiplierY: Double) {
        for index in 0 ..< points.count {
            points[index].x *= multiplierX
            points[index].y *= multiplierY
        }
    }
}

extension Vertex {
    func parseCoordinates() -> (x: Double, y: Double)? {
        var current = ""
        
        var coordinateX = 0.0
        var coordinateY = 0.0
        
        for currentSymbol in coordinates {
            if currentSymbol == Character(" ") {
                coordinateX = Double(current)!
                current = ""
            }
            else {
                current.append(currentSymbol)
            }
        }
        
        coordinateY = Double(current)!
        return (x: coordinateX, coordinateY)
    }
}

extension Poi {
    func parseCoordinates() -> (x: Double, y: Double)? {
        var current = ""
        
        var coordinateX = 0.0
        var coordinateY = 0.0
        
        for currentSymbol in coordinates {
            if currentSymbol == Character(" ") {
                coordinateX = Double(current)!
                current = ""
            }
            else {
                current.append(currentSymbol)
            }
        }
        
        coordinateY = Double(current)!
        return (x: coordinateX, coordinateY)
    }
}

extension Beacons {
    func parseCoordinates() -> (x: Double, y: Double)? {
        var current = ""
        
        var coordinateX = 0.0
        var coordinateY = 0.0
        
        for currentSymbol in coordinates {
            if currentSymbol == Character(" ") {
                coordinateX = Double(current)!
                current = ""
            }
            else {
                current.append(currentSymbol)
            }
        }
        
        coordinateY = Double(current)!
        return (x: coordinateX, coordinateY)
    }
}


extension Edge {
    func parseDoorsCoordinates() -> [(x: Double, y: Double)]? {
        
        if doorscoordinates == "nil" {
            return nil
        }
        if doorscoordinates == "0" {
            return nil
        }
        
        var current = ""
        
        var arrayToReturn = [(x: Double, y: Double)]()
        
        var coordinateX = 0.0
        var coordinateY = 0.0
        var numberOfCoordinatesFound = 0
        for currentSymbol in doorscoordinates {
            if currentSymbol == Character(" ") {
                numberOfCoordinatesFound += 1
                
                if numberOfCoordinatesFound % 2 == 1 {
                    coordinateX = Double(current)!
                }
                else {
                    coordinateY = Double(current)!
                    arrayToReturn.append((x: coordinateX, y: coordinateY))
                }
                current = ""
            }
            else {
                current.append(currentSymbol)
            }
        }
        
        if numberOfCoordinatesFound % 2 == 0 {
            return nil
        }
        
        coordinateY = Double(current)!
        arrayToReturn.append((x: coordinateX, y: coordinateY))
        
        return arrayToReturn
    }
}

extension Rooms {
    func parsePolygon() -> [(x: Double, y: Double)]? {
        var current = ""
        
        var arrayToReturn = [(x: Double, y: Double)]()
        
        var coordinateX = 0.0
        var coordinateY = 0.0
        var numberOfCoordinatesFound = 0
        for currentSymbol in polygon {
            if currentSymbol == Character(" ") {
                numberOfCoordinatesFound += 1
                
                if numberOfCoordinatesFound % 2 == 1 {
                    coordinateX = Double(current)!
                }
                else {
                    coordinateY = Double(current)!
                    arrayToReturn.append((x: coordinateX, y: coordinateY))
                }
                current = ""
            }
            else {
                current.append(currentSymbol)
            }
        }
        
        if numberOfCoordinatesFound % 2 == 0 {
            return nil
        }
        
        coordinateY = Double(current)!
        arrayToReturn.append((x: coordinateX, y: coordinateY))

        return arrayToReturn
    }
}

extension Beacons {
    static func < (lhs: Beacons, rhs: Beacons) -> Bool {
        return lhs.id < rhs.id
    }
    
    func parseMajorMinor() -> (major: Int?, minor: Int?) {
        var current = ""
        var firstNumber: Int? = nil
        var secondNumber: Int? = nil
        
        for currentSymbol in majorminor {
            if currentSymbol == Character(" ") {
                if current == "" {
                    firstNumber = nil
                }
                else {
                    firstNumber = Int(current)
                }
                
                current = ""
            }
            else {
                current.append(currentSymbol)
            }
        }
        
        if current == "" {
            secondNumber = nil
        }
        else {
            secondNumber = Int(current)
        }
        
        return (major: firstNumber, minor: secondNumber)
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}


extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size).integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height  / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}
