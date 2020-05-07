//
//  FireBaseWork.swift
//  TableData


import Foundation
import Firebase
import FirebaseDatabase
import CoreData
import UIKit

class WriteBase {
    
    
    

    func writeCampusMyas() {
    
        
        let ref = Database.database().reference()
        
        let rootRef = ref.child("Campus")
        
      
        
        let hse = rootRef.child("hse")
        let posthse = ["name": "Higher School of Economics",
                       "comment": "hse"] as [String : Any]
        hse.updateChildValues(posthse)
        
        let myas20 = hse.child("myas20")
        let postMyas20 = ["name": "Мясницкая 20",
                            "adress": "Мясницкая 20",
                            "comment": "main"] as [String : Any]
        myas20.updateChildValues(postMyas20)
        
        
        // первый этаж
        let firstFloor = myas20.child("firstFloor")
        let postfirstFloor = ["name": "1 этаж",
                              "comment": "1 этаж"] as [String : Any]
        
        firstFloor.updateChildValues(postfirstFloor)
        
        // входной холл
        let mainHall = firstFloor.child("-mainHall1")
        let postMainHall = ["name": "Холл",
                      "polygon": "98 56 110 56 110 94 98 94",
                      "comment": "Пост охраны, пропускной пункт",
                      "type": 0] as [String : Any]
        mainHall.updateChildValues(postMainHall)
        writeVertexes(room: mainHall, vertexes:
                      ["comment": "center",
                       "coordinates": "104 69"],
                      ["comment": "leftDoor",
                       "coordinates": "100 69"],
                      ["comment": "topDoor",
                       "coordinates": "104 58"],
                      ["comment": "rightDoor",
                       "coordinates": "108 69"],
                      ["comment": "bottomDoor",
                       "coordinates": "104 92"]
        )
        let mainHallBeacon = mainHall.childByAutoId()
        let postMhBeacon = ["namebeacon": "BeaconMainHall1",
                            "coordinatesbeacon": "104 65",
                            "majorminorbeacon": "1 1",
                            "uuidbeacon": "10F86430-1346-11E4-9191-0800200C9A66",
                            "commentbeacon": "бикон в главном холле 1",
                            "heightbeacon": 0] as [String : Any]
        mainHallBeacon.updateChildValues(postMhBeacon)
        
        //сачок направо от входа
        let restRoom = firstFloor.child("-restRoom1")
        let postWaitingRoom = ["name": "Комната отдыха",
                               "polygon": "110 58 145 58 145 94 110 94",
                               "comment": "Комната отдыха на 1 этаже",
                               "type": 0] as [String : Any]
        restRoom.updateChildValues(postWaitingRoom)
        
        writeVertexes(room: restRoom, vertexes:
            ["comment": "leftDoor",
             "coordinates": "112 69"],
                      ["comment": "atm",
                       "coordinates": "124 87"],
                      ["comment": "coffee",
                       "coordinates": "134 69"],
                      ["comment": "chairs",
                       "coordinates": "135 85"],
                      ["comment": "center",
                       "coordinates": "127 72"]
        )
        
        writePois (
            room: restRoom, pois:
            ["namep":"Кофейный автомат",
             "commentp": "Возможна оплата картой",
             "coordinatesp": "134 63",
            "typep":1,
            "imagep":""],
            ["namep":"Места для сидения",
             "commentp": "Рядом расположен стол",
             "coordinatesp": "140 85",
             "typep":2,
             "imagep":"0"],
            ["namep":"Банкомат Сбербанка",
             "commentp": "Бесконтактная оплата",
             "coordinatesp": "122 91",
             "typep":3,
             "imagep":"0"],
            ["namep":"Банкомат ВТБ",
             "commentp": "Возможен прием наличных",
             "coordinatesp": "128 91",
             "typep":3,
             "imagep":"0"]
        )
        
        //комната с лифтами
        let liftHall = firstFloor.child("-liftHall1")
        let postLiftHall = ["name": "Холл у лифтов",
                            "polygon": "96 35 110 35 110 56 96 56",
                            "comment": "Холл на 1 этаже с лифтами",
                            "type": 0] as [String : Any]
        liftHall.updateChildValues(postLiftHall)
        
        
        
        writeVertexes(room: liftHall, vertexes:
            ["comment": "center",
             "coordinates": "104 69"],
                      ["comment": "center",
                       "coordinates": "104 45"],
                      ["comment": "bottomDoor",
                       "coordinates": "104 54"],
                      ["comment": "toStairway",
                       "coordinates": "98 54"],
                      ["comment": "elevators",
                       "coordinates": "98 45"],
                      ["comment": "rightDoor",
                       "coordinates": "108 40"]
        )
        
        let liftHallBeacon = liftHall.childByAutoId()
        let postLhBeacon = ["namebeacon": "BeaconLiftHall1",
                        "coordinatesbeacon": "104 50",
                        "majorminorbeacon": "1 2",
                        "uuidbeacon": "10F86430-1346-11E4-9191-0800200C9A66",
                        "commentbeacon": "бикон в лифт холле 1",
                        "heightbeacon": 0] as [String : Any]
        liftHallBeacon.updateChildValues(postLhBeacon)
        
        //лифты
        let elvtr = firstFloor.child("-elvtr1")
        let postElvtr = ["name": "Лифт 1 этаж",
                            "polygon": "89 39 96 39 96 50 89 50",
                            "comment": "Лифт на 1 этаже",
                            "type": 4] as [String : Any]
        elvtr.updateChildValues(postElvtr)
        
        writeVertexes(room: elvtr, vertexes:
            ["comment": "only",
             "coordinates": "94 45"]
        )
        
        //113ауд
        let a113 = firstFloor.child("-a113")
        let postA113 = ["name": "113",
                            "polygon": "78 56 98 56 98 65 78 65",
                            "comment": "Аудитория 113, учебная",
                            "type": 1] as [String : Any]
        a113.updateChildValues(postA113)
        
        writeVertexes(room: a113, vertexes:
                      ["comment": "door",
                       "coordinates": "96 63"]
        )

        //муж туалет на 1 этаже
        let mt1fl = firstFloor.child("-manToilet1")
        let postMt = ["name": "Мужской туалет",
                        "polygon": "70 48 77 48 77 56 78 56 78 65 70 65",
                        "comment": "Оборудован для инвалидов",
                        "type": 2] as [String : Any]
        mt1fl.updateChildValues(postMt)
        
        writeVertexes(room: mt1fl, vertexes:
            ["comment": "door",
             "coordinates": "71 63"]
        )
        
        //пред-левый коридор
        let plc = firstFloor.child("-leftCoridorSmall1")
        let postpLc = ["name": "Малый коридор",
                      "polygon": "78 65 98 65 98 74 78 74",
                      "comment": "",
                      "type": 0] as [String : Any]
        plc.updateChildValues(postpLc)
        
        writeVertexes(room: plc, vertexes:
            ["comment": "rightDoor",
             "coordinates": "96 69"],
            ["comment": "leftDoor",
            "coordinates": "80 69"]
        )
        
        //левый коридор
        let lc = firstFloor.child("-leftCoridor1")
        let postLc = ["name": "Аудиторный коридор",
                      "polygon": "50 65 78 65 78 74 50 74",
                      "comment": "Проход к аудиториям",
                      "type": 0] as [String : Any]
        lc.updateChildValues(postLc)
        
        writeVertexes(room: lc, vertexes:
            ["comment": "toToilet",
             "coordinates": "71 69"]
            )
        
        writeVertexes(room: lc, vertexes:
                ["comment": "rightDoor",
                 "coordinates": "76 69"]
        )
        

        
        
        // ВТОРОЙ ЭТАЖ
        let secondFloor = myas20.child("secondFloor")
        let postSecondFloor = ["name": "2 этаж",
                              "comment": "2 этаж"] as [String : Any]
        
        secondFloor.updateChildValues(postSecondFloor)
        
        //комната с лифтами
        let liftHall2 = secondFloor.child("-liftHall2")
        let postLiftHall2 = ["name": "Холл у лифтов",
                            "polygon": "95 33 109 33 109 54 95 54",
                            "comment": "Холл на 2 этаже у лифтов",
                            "type": 0] as [String : Any]
        liftHall2.updateChildValues(postLiftHall2)
        
        writeVertexes(room: liftHall2, vertexes:
            ["comment": "elvtr",
             "coordinates": "97 43"],
                      ["comment": "center",
                       "coordinates": "102 43"],
                      ["comment": "stairway",
                       "coordinates": "97 52"],
                      ["comment": "bottomDoor",
                       "coordinates": "106 52"]
        )
        let liftHall2Beacon = liftHall2.childByAutoId()
        let postLh2Beacon = ["namebeacon": "BeaconLiftHall2",
                            "coordinatesbeacon": "102 49",
                            "majorminorbeacon": "1 3",
                            "uuidbeacon": "10F86430-1346-11E4-9191-0800200C9A66",
                            "commentbeacon": "бикон в лифт холле 2",
                            "heightbeacon": 0] as [String : Any]
        liftHall2Beacon.updateChildValues(postLh2Beacon)
        
        //лифты
        let elvtr2 = secondFloor.child("-elvtr2")
        let postElvtr2 = ["name": "Лифт 2 этаж",
                         "polygon": "87 37 95 37 95 49 87 49",
                         "comment": "Лифт на 2 этаже",
                         "type": 4] as [String : Any]
        elvtr2.updateChildValues(postElvtr2)
        
        writeVertexes(room: elvtr2, vertexes:
            ["comment": "only",
             "coordinates": "93 43"]
            
        )
        
        //коридор вниз от лифтов
        let sofaHall2 = secondFloor.child("-sofaHall2")
        let postSofaHall2 = ["name": "Проходной коридор",
                        "polygon": "96 54 109 54 109 68 96 68",
                        "comment": "Доступ к аудиториям и административным помещениям",
                        "type": 0] as [String : Any]
        sofaHall2.updateChildValues(postSofaHall2)
        
        writeVertexes(room: sofaHall2, vertexes:
            ["comment": "topDoor",
             "coordinates": "106 56"],
                      ["comment": "bottomEntranceAndDit",
                       "coordinates": "100 65"],
                      ["comment": "sofa",
                       "coordinates": "105 65"],
                      ["comment": "cooler",
                       "coordinates": "101 56"]
        )
        writePois (
            room: sofaHall2, pois:
            ["namep":"Кулер",
             "commentp": "Холодная и горячая вода",
             "coordinatesp": "98 56",
             "typep":1,
             "imagep":""],
            ["namep":"Диван",
             "commentp": "Четырехместный кожаный диван",
             "coordinatesp": "107 65",
             "typep":2,
             "imagep":"0"]
        )
        
        
        
        let sofaHall2Beacon = sofaHall2.childByAutoId()
        let postSh2Beacon = ["namebeacon": "BeaconSofaHall2",
                             "coordinatesbeacon": "104 64",
                             "majorminorbeacon": "1 4",
                             "uuidbeacon": "10F86430-1346-11E4-9191-0800200C9A66",
                             "commentbeacon": "бикон в софа холле 2",
                             "heightbeacon": 0] as [String : Any]
        sofaHall2Beacon.updateChildValues(postSh2Beacon)
        
    
        // длинный коридор 2го этажа
        let llc2 = secondFloor.child("-LeftCoridor2")
        let postLlc2 = ["name": "Длинный коридор",
                             "polygon": "57 61 96 61 96 68 57 68",
                             "comment": "Доступ к аудиториям и административным помещениям",
                             "type": 0] as [String : Any]
        llc2.updateChildValues(postLlc2)
        
        writeVertexes(room: llc2, vertexes:
            ["comment": "rightDoor",
             "coordinates": "93 65"],
            ["comment": "womanToilet",
            "coordinates": "72 65"],
            ["comment": "a227",
             "coordinates": "65 65"]
        )
        
        //мужской туалет 2 этаж
        let manToilet2 = secondFloor.child("-manToilet2")
        let postMt2 = ["name": "Мужской туалет",
                       "polygon": "76 55 96 55 96 61 76 61",
                       "comment": "Не оборудовн для инвалидов",
                       "type": 2] as [String : Any]
        
        manToilet2.updateChildValues(postMt2)
        
        writeVertexes(room: manToilet2, vertexes:
            ["comment": "door",
             "coordinates": "93 59"]
        )
        
        //женский туалет 2 этаж
        let wmanToilet2 = secondFloor.child("-womanToilet2")
        let postwMt2 = ["name": "Женский туалет",
                       "polygon": "68 43 75 43 75 55 76 55 76 61 68 61",
                       "comment": "Оборудован для инвалидов",
                       "type": 3] as [String : Any]
        
        wmanToilet2.updateChildValues(postwMt2)
        
        writeVertexes(room: wmanToilet2, vertexes:
            ["comment": "door",
             "coordinates": "72 59"]
        )
        
        // аудитория 227
        let a227 = secondFloor.child("-a227")
        let postA227 = ["name": "227",
                        "polygon": "57 43 68 43 68 61 57 61",
                        "comment": "Аудитория 227, учебная",
                        "type": 1] as [String : Any]
        a227.updateChildValues(postA227)
        
        writeVertexes(room: a227, vertexes:
            ["comment": "door",
             "coordinates": "65 59"]
        )
        
    }
    
    
    // заполняем эджи для мясницкой 20
    func writeEdgesMyas() {
        //первый этаж
        
        //идут в порядке добавления
        let floor1 = Database.database().reference().child("Campus/hse/myas20/firstFloor/")
        
        //внутри мейн холла
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-mainHall1",
                                                           "vert1":"center",
                                                           "room2":"-mainHall1",
                                                           "vert2":"leftDoor"],
                                                     edgeParams: ["distance":"5",
                                                                  "commentEdge":"<",
                                                                  "doorscoordinates":0
            ])
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-mainHall1",
                                                "vert1":"center",
                                                "room2":"-mainHall1",
                                                "vert2":"topDoor"],
                                          edgeParams: ["distance":"10",
                                                       "commentEdge":"/\\",
                                            "doorscoordinates":0
            ])
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-mainHall1",
                                                "vert1":"center",
                                                "room2":"-mainHall1",
                                                "vert2":"rightDoor"],
                                          edgeParams: ["distance":"5",
                                                       "commentEdge":"/\\",
                                                       "doorscoordinates":0
            ])
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-mainHall1",
                                                "vert1":"center",
                                                "room2":"-mainHall1",
                                                "vert2":"bottomDoor"],
                                          edgeParams: ["distance":"17",
                                                       "commentEdge":"/\\",
                                                       "doorscoordinates":0
            ])
        
        //из мейн холла в левый коридор
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-leftCoridorSmall1",
                                                "vert1":"rightDoor",
                                                "room2":"-mainHall1",
                                                "vert2":"leftDoor"],
                                          edgeParams: ["distance":"4",
                                                       "commentEdge":"",
                                                       "doorscoordinates":"98 67 98 71"
            ])
        
        //из мейн холла в лифтхолл
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-mainHall1",
                                                "vert1":"topDoor",
                                                "room2":"-liftHall1",
                                                "vert2":"bottomDoor"],
                                          edgeParams: ["distance":"4",
                                                       "commentEdge":"liha-maha",
                                                       "doorscoordinates":"101 56 107 56"//?
            ])
        
        //внури лифтхолла
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-liftHall1",
                                                "vert1":"elevators",
                                                "room2":"-liftHall1",
                                                "vert2":"bottomDoor"],
                                          edgeParams: ["distance":"10",
                                                       "commentEdge":"lifthall",
                                                       "doorscoordinates":"0"
            ])
        
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-liftHall1",
                                                "vert1":"toStairway",
                                                "room2":"-liftHall1",
                                                "vert2":"bottomDoor"],
                                          edgeParams: ["distance":"5",
                                                       "commentEdge":"",
                                                       "doorscoordinates":"0"
            ])
        
        
        //малый коридор
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-leftCoridorSmall1",
                                                "vert1":"leftDoor",
                                                "room2":"-leftCoridorSmall1",
                                                "vert2":"rightDoor"],
                                          edgeParams: ["distance":"15",
                                                       "commentEdge":"insideLeftCorr",
                                                       "doorscoordinates":"0"
            ])
        
        //из малого левого коридора в а113
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-leftCoridorSmall1",
                                                "vert1":"rightDoor",
                                                "room2":"-a113",
                                                "vert2":"door"],
                                          edgeParams: ["distance":"6",
                                                       "commentEdge":"a113 - leftcorrsmall",
                                                       "doorscoordinates":"95 65 97 65"
            ])
        
        
        //из малого левого кор в большой левый кор
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-leftCoridor1",
                                                "vert1":"rightDoor",
                                                "room2":"-leftCoridorSmall1",
                                                "vert2":"leftDoor"],
                                          edgeParams: ["distance":"4",
                                                       "commentEdge":"leftSmallCorrToLeftCorr",
                                                       "doorscoordinates":"78 67 78 71"
            ])
        
        //в большом левом коридоре
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-leftCoridor1",
                                                "vert1":"toToilet",
                                                "room2":"-leftCoridor1",
                                                "vert2":"rightDoor"],
                                          edgeParams: ["distance":"4",
                                                       "commentEdge":"leftcorrleftedge",
                                                       "doorscoordinates":"78 67 78 71"
            ])
        
        
        //из большого левого корр в мужской туалет
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-leftCoridor1",
                                                "vert1":"toToilet",
                                                "room2":"-manToilet1",
                                                "vert2":"door"],
                                          edgeParams: ["distance":"6",
                                                       "commentEdge":"leftCorrToToilet",
                                                       "doorscoordinates":"70 65 72 65"
            ])
        
        //из лифтхолла в лифт
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-liftHall1",
                                                "vert1":"elevators",
                                                "room2":"-elvtr1",
                                                "vert2":"only"],
                                          edgeParams: ["distance":"4",
                                                       "commentEdge":"lifthalltoelvtr",
                                                       "doorscoordinates":"96 43 96 47"
            ])

        //комната отдыха 1 этаж
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-mainHall1",
                                                               "vert1":"rightDoor",
                                                               "room2":"-restRoom1",
                                                               "vert2":"leftDoor"],
                                          edgeParams: ["distance":"4",
                                                       "commentEdge":"из главного холла в сачок",
                                                       "doorscoordinates":"110 66 110 72"
            ])
        
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-restRoom1",
                                                               "vert1":"atm",
                                                               "room2":"-restRoom1",
                                                               "vert2":"leftDoor"],
                                          edgeParams: ["distance":"10",
                                                       "commentEdge":"от входа к банкомату",
                                                       "doorscoordinates":"0"
            ])
        
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-restRoom1",
                                                               "vert1":"leftDoor",
                                                               "room2":"-restRoom1",
                                                               "vert2":"coffee"],
                                          edgeParams: ["distance":"11",
                                                       "commentEdge":"от входа к кофе",
                                                       "doorscoordinates":"110 66 110 72"
            ])
        
        searchVertexAndCreateEdgesOnFloor(floor: floor1, rAv: ["room1":"-restRoom1",
                                                               "vert1":"leftDoor",
                                                               "room2":"-restRoom1",
                                                               "vert2":"chairs"],
                                          edgeParams: ["distance":"14",
                                                       "commentEdge":"от входа к сиденьям",
                                                       "doorscoordinates":"110 66 110 72"
            ])
        
       
        
        //межэтажка
       
        
        //ВТОРОЙ ЭТАЖ
        let floor2 = Database.database().reference().child("Campus/hse/myas20/secondFloor/")
        
        //из лифтхолла в лифт
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-elvtr2",
                                                               "vert1":"only",
                                                               "room2":"-liftHall2",
                                                               "vert2":"elvtr"],
                                          edgeParams: ["distance":"4",
                                                       "commentEdge":"lifthalltoelvtr2",
                                                       "doorscoordinates":"95 41 95 45"
            ])
        
        //внутри лифтхолла
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-liftHall2",
                                                               "vert1":"center",
                                                               "room2":"-liftHall2",
                                                               "vert2":"elvtr"],
                                          edgeParams: ["distance":"4",
                                                       "commentEdge":"lifthallelvtr-centr2",
                                                       "doorscoordinates":"0"
            ])
        
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-liftHall2",
                                                               "vert1":"center",
                                                               "room2":"-liftHall2",
                                                               "vert2":"bottomDoor"],
                                          edgeParams: ["distance":"10",
                                                       "commentEdge":"lifthallcentr-bottomd",
                                                       "doorscoordinates":"0"
            ])
        
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-liftHall2",
                                                               "vert1":"center",
                                                               "room2":"-liftHall2",
                                                               "vert2":"bottomDoor"],
                                          edgeParams: ["distance":"10",
                                                       "commentEdge":"lifthallcentr-bottomd",
                                                       "doorscoordinates":"0"
            ])
        
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-liftHall2",
                                                               "vert1":"stairway",
                                                               "room2":"-liftHall2",
                                                               "vert2":"bottomDoor"],
                                          edgeParams: ["distance":"9",
                                                       "commentEdge":"lifthallstairway-bottomd",
                                                       "doorscoordinates":"0"
            ])
        
        //между лифт и софа
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-liftHall2",
                                                               "vert1":"bottomDoor",
                                                               "room2":"-sofaHall2",
                                                               "vert2":"topDoor"],
                                          edgeParams: ["distance":"6",
                                                       "commentEdge":"lifthall-sofahall",
                                                       "doorscoordinates":"104 54 108 54"
            ])
        
        //софа
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-sofaHall2",
                                                               "vert1":"topDoor",
                                                               "room2":"-sofaHall2",
                                                               "vert2":"bottomEntranceAndDit"],
                                          edgeParams: ["distance":"10",
                                                       "commentEdge":"sofahall-top-bottom",
                                                       "doorscoordinates":"0"
            ])
        
        // между софа и длинным коридором
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-sofaHall2",
                                                               "vert1":"bottomEntranceAndDit",
                                                               "room2":"-LeftCoridor2",
                                                               "vert2":"rightDoor"],
                                          edgeParams: ["distance":"7",
                                                       "commentEdge":"sofahall-lefthall2",
                                                       "doorscoordinates":"96 61 96 68"
            ])
        
        
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-sofaHall2",
                                                               "vert1":"bottomEntranceAndDit",
                                                               "room2":"-sofaHall2",
                                                               "vert2":"cooler"],
                                          edgeParams: ["distance":"8",
                                                       "commentEdge":"",
                                                       "doorscoordinates":"0"
        ])
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-sofaHall2",
                                                               "vert1":"bottomEntranceAndDit",
                                                               "room2":"-sofaHall2",
                                                               "vert2":"sofa"],
                                          edgeParams: ["distance":"6",
                                                       "commentEdge":"",
                                                       "doorscoordinates":"0"
        ])
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-sofaHall2",
                                                               "vert1":"topDoor",
                                                               "room2":"-sofaHall2",
                                                               "vert2":"cooler"],
                                          edgeParams: ["distance":"7",
                                                       "commentEdge":"",
                                                       "doorscoordinates":"0"
        ])
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-sofaHall2",
                                                               "vert1":"topDoor",
                                                               "room2":"-sofaHall2",
                                                               "vert2":"sofa"],
                                          edgeParams: ["distance":"7",
                                                       "commentEdge":"",
                                                       "doorscoordinates":"0"
        ])
        
        // длинный коридор -  мужской туалет
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-LeftCoridor2",
                                                               "vert1":"rightDoor",
                                                               "room2":"-manToilet2",
                                                               "vert2":"door"],
                                          edgeParams: ["distance":"6",
                                                       "commentEdge":"lefthall-mantoilet",
                                                       "doorscoordinates":"92 61 94 61"
            ])
        
        //длинный коридор - женский туалет
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-LeftCoridor2",
                                                               "vert1":"womanToilet",
                                                               "room2":"-womanToilet2",
                                                               "vert2":"door"],
                                          edgeParams: ["distance":"6",
                                                       "commentEdge":"lefthall-womantoilet",
                                                       "doorscoordinates":"71 61 73 61"
            ])
        //длинный коридор - ауд 227
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-LeftCoridor2",
                                                               "vert1":"a227",
                                                               "room2":"-a227",
                                                               "vert2":"door"],
                                          edgeParams: ["distance":"6",
                                                       "commentEdge":"lefthall2-a227",
                                                       "doorscoordinates":"64 61 66 61"
            ])
        
        // длинный коридор (муж туалет) - длинный коридор (жен туалет)
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-LeftCoridor2",
                                                               "vert1":"rightDoor",
                                                               "room2":"-LeftCoridor2",
                                                               "vert2":"womanToilet"],
                                          edgeParams: ["distance":"2",
                                                       "commentEdge":"",
                                                       "doorscoordinates":"0"
            ])
        
        // длинный коридор (жен туалет) - длинный коридор (а227)
        searchVertexAndCreateEdgesOnFloor(floor: floor2, rAv: ["room1":"-LeftCoridor2",
                                                               "vert1":"womanToilet",
                                                               "room2":"-LeftCoridor2",
                                                               "vert2":"a227"],
                                          edgeParams: ["distance":"2",
                                                       "commentEdge":"",
                                                       "doorscoordinates":"0"
            ])
        
    }
    
    
    
   
    
    func searchVertexAndCreateEdgesOnFloor(floor: DatabaseReference, rAv: [String : String], edgeParams: [String:Any]) {
        // defineFloorRef
        
        var vert1code: String?
        var vert2code: String?
        
        guard let room1 = rAv["room1"], let room2 = rAv["room2"], let vert1 = rAv["vert1"], let vert2 = rAv["vert2"] else {print ("rAv is bad"); return }
        
        floor.observeSingleEvent(of: .value, with: { snapshot in
            let snR1 = snapshot.childSnapshot(forPath: room1)
            let snR2 = snapshot.childSnapshot(forPath: room2)
            if !snR1.exists() || !snR2.exists() { print("no such room"); return }
            var success = false
            for vert in snR1.children.allObjects as! [DataSnapshot] {
//                print (vert)
                if !vert.hasChild("comment") || vert.childrenCount != 2 { continue } //
                if vert.childSnapshot(forPath: "comment").valueInExportFormat() as! String == vert1 {
                    vert1code = vert.key
                    success = true
                }
            }
            if !success {
                print ("no such vert1")
            }
            success = false
            for vert in snR2.children.allObjects as! [DataSnapshot] {
//                print (vert)
                if !vert.hasChild("comment") || vert.childrenCount != 2 { continue } //
                if vert.childSnapshot(forPath: "comment").valueInExportFormat() as! String == vert2 {
                    vert2code = vert.key
                    success = true
                }
            }
            if !success {
                print ("no such vert1")
            }
            
            guard let v1code = vert1code, let v2code = vert2code else { print ("one of vert codes is empty") ; return}
            
            let ref = Database.database().reference().child("Edge")
            
            guard let distance = edgeParams["distance"], let commentEdge = edgeParams["commentEdge"], let doorscoordinates = edgeParams["doorscoordinates"] else {print ("edgeParams is bad"); return }
            
            let edgeFrom = ref.childByAutoId()
            var postedgeFrom = [
                "distance": distance,
                "commentEdge": commentEdge,
                "vertexfrom": v1code,
                "vertexto": v2code,
                "doorscoordinates": doorscoordinates] as [String : Any]
            edgeFrom.updateChildValues(postedgeFrom)
            
            print (postedgeFrom)
            let edgeTo = ref.childByAutoId()
            (postedgeFrom["vertexfrom"],postedgeFrom[ "vertexto"]) = (postedgeFrom[ "vertexto"], postedgeFrom["vertexfrom"])
            
            edgeTo.updateChildValues(postedgeFrom)
            print (postedgeFrom)
            print ("successfully written edges")
        })
       
    }

 
    func writeEdgesBetweenFloors () {
        
        // соединяем лифты
        
        let ref = Database.database().reference().child("Edge")
        let edgeFrom = ref.childByAutoId()
        var postedgeFrom = [
            "distance": "0",
            "commentEdge": "elvtr1-elvtr2",
            "vertexfrom": "-LpJwW4razGDfyWqjQKl",
            "vertexto": "-LpJwW4wpIcjwia1wpYT",
            "doorscoordinates": "0"] as [String : Any]
        edgeFrom.updateChildValues(postedgeFrom)
 
        
        print (postedgeFrom)
        let edgeTo = ref.childByAutoId()
        (postedgeFrom["vertexfrom"],postedgeFrom[ "vertexto"]) = (postedgeFrom[ "vertexto"], postedgeFrom["vertexfrom"])
        
        edgeTo.updateChildValues(postedgeFrom)
        print (postedgeFrom)
        print ("successfully written edges between floor")
    }
    
    func writeVertexes (room: DatabaseReference, vertexes: [String : Any]...){
        
        for vertexData in vertexes {
            let vertex = room.childByAutoId()
            vertex.updateChildValues(vertexData)
        }
    }
    
    func writePois (room: DatabaseReference, pois: [String : Any]...){
        
        for poiData in pois {
            let poi = room.childByAutoId()
            poi.updateChildValues(poiData)
        }
    }
    
    func writeBuildings2(){
        let ref = Database.database().reference().child("Campus").child("-LmEYIRXQiWNy2Pv1pmc")
        
        let Building = ref.childByAutoId()
        let postBuilding = ["name": "Мясницкая 20",
                                "adress": "Мясницкая 20",
                                "comment": "main"] as [String : Any]
        Building.updateChildValues(postBuilding)
        
    }
    
    func writeFloors2() {
        let ref = Database.database().reference().child("Campus").child("-LmEYIRXQiWNy2Pv1pmc").child("-LmEaR7wSeiAtGU8-m36")
        
        let firstFloor = ref.childByAutoId()
        let postfirstFloor = ["name": "1 этаж",
                              "comment": "1 этаж"] as [String : Any]
        
        firstFloor.updateChildValues(postfirstFloor)
        
    }
    

    

    
    func writeEdge2() {
        let ref = Database.database().reference().child("Edge")
        
        let edgeFrom = ref.childByAutoId()
        let postedgeFrom = [
            "distance": "4.25" ,
            "commentEdge":"[[[",
            "vertexfrom": "Campus/-LmEYIRXQiWNy2Pv1pmc/-LmEaR7wSeiAtGU8-m36/-LmEdi3NDsi4x-yl7TvV/-LmPtOTsDbiYbnSQNxNc/-LmQW2uXDrnqPxlk8Lpn",
            "vertexto": "Campus/-LmEYIRXQiWNy2Pv1pmc/-LmEaR7wSeiAtGU8-m36/-LmEdi3NDsi4x-yl7TvV/-LmPtOTsDbiYbnSQNxNc/-LmQW2u_i0bZwkPLAKzc",
            "doorscoordinates": 0] as [String : Any]
        edgeFrom.updateChildValues(postedgeFrom)
        
        let edgeTo = ref.childByAutoId()
        let postedgeTo = [
            "distance": "4.25",
            "commentEdge":"[[[",
            "vertexfrom": "Campus/-LmEYIRXQiWNy2Pv1pmc/-LmEaR7wSeiAtGU8-m36/-LmEdi3NDsi4x-yl7TvV/-LmPtOTsDbiYbnSQNxNc/-LmQW2u_i0bZwkPLAKzc",
            "vertexto": "Campus/-LmEYIRXQiWNy2Pv1pmc/-LmEaR7wSeiAtGU8-m36/-LmEdi3NDsi4x-yl7TvV/-LmPtOTsDbiYbnSQNxNc/-LmQW2uXDrnqPxlk8Lpn",
            "doorscoordinates": 0] as [String : Any]
        edgeTo.updateChildValues(postedgeTo)
        
    }

    
    func readRoom1(snapshot: DataSnapshot) {
        var nameCampus = " "
        var commentCampus = " "
        var idCampus: String = " "
        var valueCampus = 0
        var campusArray = [Campus]()
        
        var distanceEdge = "0.0"
        var doorscoordinatesEdge: String = "nil"
        var vertexfromEdge = " "
        var vertextoEdge = " "
        var idEdge = " "
        var commentEdge = " "
        var valueEdge = 0
        var edgeArray = [Edge]()
        
        var adressBuilding = " "
        var commentBuilding = " "
        var nameBuilding = " "
        var idBuilding = " "
        var valueBuilding = 0
        var buildingArray = [Buildings]()
        
        var commentFloor = " "
        var nameFloor = " "
        var idFloor = " "
        var valueFloor = 0
        var floorArray = [Floors]()
        
        var commentRoom = " "
        var nameRoom = " "
        var polygonRoom = " "
        var typeRoom = 0
        var idRoom = " "
        var valueRoom = 0
        var roomArray = [Rooms]()
        
        var commentVertex : String = " "
        var coordinatesVertex : String = " "
        var idVertex : String = " "
        var valueVertex : Int = 0
        var vertexArray = [Vertex]()
        
        var coordinatesBeacon = " "
        var commentBeacon = " "
        var nameBeacon = " "
        var majorminorBeacon = " "
        var uuidBeacon = " "
        var idBeacon = " "
        var valueBeacon = 0
        var heightBeacon = "0.0"
        var beaconArray = [Beacons]()
        
        var cordinatesSession = " "
        var dt_startSession = NSDate()
        var dt_endSession = NSDate()
        var dt_modificationSession = NSDate()
        var commentSession = " "
        var idSession = " "
        var valueSession = 0
//        var sessionArray = [Session]()
        
        var imagePoi = " "
        var commentPoi = " "
        var coordinatesPoi = " "
        var namePoi = " "
        var idPoi = " "
        var typePoi = 0
        var valuePoi = 0
        var poiArray = [Poi]()
        
        
        // прикрепляем observer к базе данных, его код срабатывает однажды в момент первого выполнения (запуска), и впоследствии каждый раз при изменении бд
       
            print ("database observer callback started")
            //состояние бд находится в этом snapshot
            

            if let allData = snapshot.children.allObjects as? [DataSnapshot] {
                for data in allData {
                    
                   
                    if data.children.allObjects as? [DataSnapshot] == nil {
                        print("Error")
                        return
                    }
                    
                    for first in data.children.allObjects as! [DataSnapshot] {
                        if first.children.allObjects as? [DataSnapshot] == nil {
                            print("Error")
                            return
                        }
                        
                        var flagCampus = 0
                        for campusANDedge in first.children.allObjects as! [DataSnapshot] {
                            // внутри campusANDedge оказываются содержимое компонентов первого уровня вложенности в campus или edge (компоненты со  странными именами) - это id кампуса или edge-a
                            if campusANDedge.key == "name" { /* Кампус */
                                nameCampus = campusANDedge.value as? String ?? ""
                                idCampus = first.key
                                valueCampus += 1
                            }
                            if campusANDedge.key == "comment" { /* Кампус */
                                commentCampus = campusANDedge.value as? String ?? ""
                                valueCampus += 1
                            }
                            if campusANDedge.key == "distance" { /* Ребро */
                                distanceEdge = campusANDedge.value as? String ?? ""
                                idEdge = first.key
                                valueEdge += 1
                            }
                            if campusANDedge.key == "doorscoordinates" { /* Ребро */
                                print ("dc RED")
                                doorscoordinatesEdge = campusANDedge.value as? String ?? ""
                                valueEdge += 1
                            }
                            if campusANDedge.key == "vertexfrom" { /* Ребро */
                                vertexfromEdge = campusANDedge.value as? String ?? ""
                                valueEdge += 1
                            }
                            if campusANDedge.key == "vertexto" { /* Ребро */
                                vertextoEdge = campusANDedge.value as? String ?? ""
                                valueEdge += 1
                            }
                            if campusANDedge.key == "commentEdge" { /* Ребро */
                                commentEdge = campusANDedge.value as? String ?? ""
                                valueEdge += 1
                            }
                            if valueCampus == 2 {
                                let campusA = Campus(id: idCampus, name: nameCampus, comment: commentCampus)
                                campusArray.append(campusA)
                                valueCampus = 0
                                flagCampus = 1
                            }
                            if valueEdge == 5 {
                                let EdgeA = Edge(id: idEdge, distance: distanceEdge, doorscoordinates: doorscoordinatesEdge, comment: commentEdge, vertexto: vertextoEdge, vertexfrom: vertexfromEdge)
                                print (EdgeA)
                                edgeArray.append(EdgeA)
                                valueEdge = 0
                            }
                            
                            if campusANDedge.children.allObjects as? [DataSnapshot] == nil {
                                print("Error")
                                break
                            }
                            
                            // здесь начинаются вложенные в campus компоненты
                            var flagBuild = 0
                            
                            //это перебор элементов, составляющих здание
                            for build in campusANDedge.children.allObjects as! [DataSnapshot] {
                                if build.key == "adress" { /* Здание */
                                    adressBuilding = build.value as? String ?? ""
                                    idBuilding = campusANDedge.key
                                    valueBuilding += 1
                                }
                                if build.key == "comment" { /* Здание */
                                    commentBuilding = build.value as? String ?? ""
                                    valueBuilding += 1
                                }
                                if build.key == "name" { /* Здание */
                                    nameBuilding = build.value as? String ?? ""
                                    valueBuilding += 1
                                }
                                if valueBuilding == 3 {
                                    let BuildinA = Buildings(id: idBuilding, name: nameBuilding, comment: commentBuilding, adress: adressBuilding)
                                    buildingArray.append(BuildinA)
                                    valueBuilding = 0
                                    flagBuild = 1
                                }
                                
                                if build.children.allObjects as? [DataSnapshot] == nil {
                                    print("Error")
                                    break
                                }
                                
                                var flagFloor = 0
                                
                                //это перебор элементов, составляющих этаж
                                for floor in build.children.allObjects as! [DataSnapshot] {
                                    if floor.key == "comment" { /* Этаж */
                                        commentFloor = floor.value as? String ?? ""
                                        idFloor = build.key
                                        valueFloor += 1
                                    }
                                    if floor.key == "name" { /* Этаж */
                                        nameFloor = floor.value as? String ?? ""
                                        valueFloor += 1
                                    }
                                    if valueFloor == 2 {
                                        let FloorA = Floors(id: idFloor, name: nameFloor, comment: commentFloor)
                                        floorArray.append(FloorA)
                                        valueFloor = 0
                                        flagFloor = 1
                                    }
                                    
                                    if floor.children.allObjects as? [DataSnapshot] == nil {
                                        print("Error")
                                        break
                                    }
                                    
                                    var flagRoom = 0
                                    //это перебор элементов, составляющих комнату
                                    for room in floor.children.allObjects as! [DataSnapshot] {
                                        
                                        var flagRoomNote = true
                                        if room.key == "comment" { /* Комната */
                                            commentRoom = room.value as? String ?? ""
                                            idRoom = floor.key
                                            valueRoom += 1
                                            flagRoomNote = false
                                        }
                                        if room.key == "name" { /* Комната */
                                            nameRoom = room.value as? String ?? ""
                                            valueRoom += 1
                                            flagRoomNote = false
                                        }
                                        if room.key == "polygon" { /* Комната */
                                            polygonRoom = room.value as? String ?? ""
                                            valueRoom += 1
                                            flagRoomNote = false
                                        }
                                        if room.key == "type" { /* Комната */
                                            typeRoom = room.value as? Int ?? -1
                                            valueRoom += 1
                                            flagRoomNote = false
                                        }
                                        if valueRoom == 4 {
                                            let roomA = Rooms(id: idRoom, comment: commentRoom, polygon: polygonRoom, name: nameRoom, type: typeRoom)
                                            roomArray.append(roomA)
                                            flagRoom = 3
                                            
                                            valueRoom = 0
                                        }
                                        if flagRoomNote {
                                            if room.children.allObjects as? [DataSnapshot] == nil {
                                                print("Error")
                                                break
                                            }
                                      
                                            for vertex in room.children.allObjects as! [DataSnapshot] {
                                                if vertex.key == "comment" { /* Вершина */
                                                    commentVertex = vertex.value as? String ?? ""
                                                    idVertex = room.key
                                                    valueVertex += 1
                                                }
                                                if vertex.key == "coordinates" { /* Вершина */
                                                    coordinatesVertex = vertex.value as? String ?? ""
                                                    valueVertex += 1
                                                }
                                                if vertex.key == "coordinatesbeacon" { /* Beacon */
                                                    coordinatesBeacon = vertex.value as? String ?? ""
                                                    idBeacon = room.key
                                                    valueBeacon += 1
                                                }
                                                if vertex.key == "commentbeacon" { /* Beacon */
                                                    commentBeacon = vertex.value as? String ?? ""
                                                    valueBeacon += 1
                                                }
                                                if vertex.key == "namebeacon" { /* Beacon */
                                                    nameBeacon = vertex.value as? String ?? ""
                                                    valueBeacon += 1
                                                }
                                                if vertex.key == "majorminorbeacon" { /* Beacon */
                                                    majorminorBeacon = vertex.value as? String ?? ""
                                                    valueBeacon += 1
                                                }
                                                if vertex.key == "uuidbeacon" { /* Beacon */
                                                    uuidBeacon = vertex.value as? String ?? ""
                                                    valueBeacon += 1
                                                }
                                                if vertex.key == "heightbeacon" { /* Beacon */
                                                    heightBeacon = vertex.value as? String ?? ""
                                                    valueBeacon += 1
                                                }
                                                if vertex.key == "cordinatessession" { /* Сессия */
                                                    cordinatesSession = vertex.value as? String ?? ""
                                                    idSession = room.key
                                                    valueSession += 1
                                                }
                                                if vertex.key == "dt_startsession" { /* Сессия */
                                                    dt_startSession = vertex.value as? NSDate ?? NSDate()
                                                    valueSession += 1
                                                }
                                                if vertex.key == "dt_endsession" { /* Сессия */
                                                    dt_endSession = vertex.value as? NSDate ?? NSDate()
                                                    valueSession += 1
                                                }
                                                if vertex.key == "dt_modificationsession" { /* Сессия */
                                                    dt_modificationSession = vertex.value as? NSDate ?? NSDate()
                                                    valueSession += 1
                                                }
                                                if vertex.key == "commentsession" { /* Сессия */
                                                    commentSession = vertex.value as? String ?? ""
                                                    valueSession += 1
                                                }
                                                
                                                if vertex.key == "namep" { /* Пои */
                                                    namePoi = vertex.value as? String ?? ""
                                                    idPoi = room.key
                                                    valuePoi += 1
                                                }
                                                if vertex.key == "commentp" { /* Пои */
                                                    commentPoi = vertex.value as? String ?? ""
                                                    valuePoi += 1
                                                }
                                                if vertex.key == "coordinatesp" { /* Пои */
                                                    coordinatesPoi = vertex.value as? String ?? ""
                                                    valuePoi += 1
                                                }
                                                if vertex.key == "imagep" { /* Пои */
                                                    imagePoi = vertex.value as? String ?? ""
                                                    valuePoi += 1
                                                }
                                                if vertex.key == "typep" { /* Пои */
                                                    typePoi = vertex.value as? Int ?? -1
                                                    valuePoi += 1
                                                    
                                                }
                                                
                                                if valuePoi == 5 {
                                                    
                                                    let poiA = Poi(id: idPoi, coordinates: coordinatesPoi, comment: commentPoi, image: imagePoi, name: namePoi, type: typePoi)
                                                    poiArray.append(poiA)
                                                    valuePoi = 0
                                                }
                                                
                                                if valueVertex == 2 {
                                                    let vertexA = Vertex(id: idVertex, coordinates: coordinatesVertex, comment: commentVertex)
                                                    vertexArray.append(vertexA)
                                                    valueVertex = 0
                                                }
                                                if valueBeacon == 6 {
                                                    let beaconA = Beacons(id: idBeacon, name: nameBeacon, coordinates: coordinatesBeacon, majorminor: majorminorBeacon, uuid: uuidBeacon, comment: commentBeacon, height: heightBeacon)
                                                    beaconArray.append(beaconA)
                                                    valueBeacon = 0
                                                }
                                                if valueSession == 5 {
//                                                    let sessionA = Session(id: idSession, cordinates: cordinatesSession, dt_start: dt_startSession, dt_end: dt_endSession, dt_modification: dt_modificationSession, comment: commentSession)
//                                                    sessionArray.append(sessionA)
                                                    valueSession = 0
                                                }
                                            }
                                        }
                                        
                                        if vertexArray.count > 0 && flagRoom > 0 {
                                            roomArray.last!.vertexrelationship = NSOrderedSet(array: vertexArray)
                                            flagRoom -= 1
                                            for vertexArr in vertexArray{
                                                vertexArr.roomsrelationship = roomArray.last
                                            }
                                            vertexArray = []
                                        }
                                        
                                        if beaconArray.count > 0 && flagRoom > 0 {
                                            roomArray.last!.beaconsrelationship = NSOrderedSet(array: beaconArray)
                                            flagRoom -= 1
                                            for beaconArr in beaconArray{
                                                beaconArr.roomsrelationship = roomArray.last
                                            }
                                            beaconArray = []
                                        }
                                        
                                        if /*sessionArray.count > 0 &&*/ flagRoom > 0 {
//                                            roomArray.last!.sessioinrelationship = NSOrderedSet(array: sessionArray)
                                            flagRoom -= 1
////                                            for sessionArr in sessionArray{
//                                                sessionArr.roomsrelationship = roomArray.last
//                                            }
//                                            sessionArray = []
                                        }
                                    
                                        if poiArray.count > 0 && flagRoom > 0 {
                                            roomArray.last!.poirelationship = NSOrderedSet(array: poiArray)
                                            flagRoom -= 1
                                            for poiArr in poiArray{
                                                
                                                poiArr.roomsrelationship = roomArray.last
                                                print ("last")
                                                print (poiArr.roomsrelationship!)
                                                
                                            }
                                            
                                            poiArray = []
                                        }
                                        
                                    }
                                    
                                    if roomArray.count > 0 && flagFloor > 0 {
                                        floorArray.last!.roomsrelationship = NSOrderedSet(array: roomArray)
                                        flagFloor -= 1
                                        for roomArr in roomArray{
                                            roomArr.floorsrelationship = floorArray.last
                                        }
                                        roomArray = []
                                    }
                                }
                                
                                if floorArray.count > 0 && flagBuild > 0 {
                                    buildingArray.last!.floorsrelationship = NSOrderedSet(array: floorArray)
                                    flagBuild -= 1
                                    for floorArr in floorArray{
                                        floorArr.buildingsrelationship = buildingArray.last
                                    }
                                    floorArray = []
                                }
                            }
                            
                            if buildingArray.count > 0 && flagCampus > 0 {
                                campusArray.last!.buildingsrelationship = NSOrderedSet(array: buildingArray)
                                flagCampus -= 1
                                for buildingArr in buildingArray{
                                    buildingArr.campusrelationship = campusArray.last
                                }
                                buildingArray = []
                            }
                        }
                    }
                }
            }
            
            let arrayEdgeForVertex = Edge.allitems()
            let arrayVertexForEdge = Vertex.allitems()
            
            for edgeForVertex in arrayEdgeForVertex {
                for VertexForEdge in arrayVertexForEdge {
                    if VertexForEdge.id == edgeForVertex.vertexfrom {
                        edgeForVertex.vertexfromrelationship = VertexForEdge
                    }
                    if VertexForEdge.id == edgeForVertex.vertexto {
                        edgeForVertex.vertextorelationship = VertexForEdge
                    }
                }
            }
        
        allVertexes = Vertex.allitems()
        allEdges = Edge.allitems()
        allRooms = Rooms.allitems()
        allPois = Poi.allitems()
        allFloors = Floors.allitems()
        getDataBeacons = Beacons.allitems()
        allFloors = allFloors.sorted(by: { $0.name ?? "kek" < $1.name ?? "kek" })
    }
    
    func saving () {
        if context1.hasChanges {
            do {
                try context1.save()
            } catch {
                print("Error")
            }
        }
    }
}
