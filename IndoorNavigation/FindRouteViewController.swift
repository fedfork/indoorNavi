//
//  FindRouteViewController.swift
//  indoor navigation a


import UIKit


class FindRouteViewController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: FinderInsideDelegate?
    

    @IBOutlet weak var fromField: UITextField!
    
    @IBOutlet weak var toField: UITextField!
    
    @IBOutlet weak var selector: UISegmentedControl! // от меня или от пункта
    
    var currentRoom: Rooms? = nil //получает от родителя
    
    var roomFrom: Rooms?
    
    var roomTo: Rooms?
    
    var poiTo: Poi?
    
    @IBAction func indexChanged(_ sender: Any) {
            switch selector.selectedSegmentIndex
            {
                case 0:
                    fromField.text = "Мое местоположение"
                    fromField.isEnabled = false
                    toField.isEnabled = true
                    roomFrom = currentRoom
                case 1:
                    fromField.text = ""
                    roomFrom = nil
                    fromField.isEnabled = true
                    toField.isEnabled = false
                    roomFrom = nil
                default:
                    break
            }
        
        
    }
    //срабатывает при нажатии кнопки Проложить
    @IBAction func onRouteClick(_ sender: Any) {
        guard var from = roomFrom?.id else {
            let alert = UIAlertController(title: "Ошибка", message: "Заполните поле \"Откуда\"", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let mainQueue = DispatchQueue.main
            let deadline = DispatchTime.now() + .seconds(2)
            mainQueue.asyncAfter(deadline: deadline) {
                alert.dismiss(animated: true, completion: nil)
            }
            return
            }
        
        
        
        // если это комната
        if let roomTo = roomTo {
            if selector.selectedSegmentIndex == 0 {
                from = ""
            }
            delegate?.newSearch(dismissController: true, fromId: from, ToId: roomTo.id)
            
            guard let navVc = navigationController else {
                print ("SearchRouteViewController::tablreView::didSelectRowAt:: navigationController doesnt exists")
                return
            }
            navVc.popViewController(animated: true)
        } else if let poiTo = poiTo { //если это POI
            if selector.selectedSegmentIndex == 0 {
                from = ""
            }
            delegate?.newSearchPoi(dismissController: true, fromRoomId: from, ToId: poiTo.id)
            
            guard let navVc = navigationController else {
                print ("SearchRouteViewController::tablreView::didSelectRowAt:: navigationController doesnt exists")
                return
            }
            navVc.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Заполните поле \"Куда\"", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let mainQueue = DispatchQueue.main
            let deadline = DispatchTime.now() + .seconds(2)
            mainQueue.asyncAfter(deadline: deadline) {
                alert.dismiss(animated: true, completion: nil)
            }
            return
        }
        
       
        
    }
    
    
    // в зависимости от доступности текущего местоположения
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        fromField.delegate = self
        toField.delegate = self
        
            //устанавливаем доступность селектора в зависимости от доступности местоположения
        
            if currentRoom != nil {
                selector.setEnabled(true, forSegmentAt: 0)
                selector.selectedSegmentIndex = 0
                fromField.text = "Мое местоположение"
                fromField.isEnabled = false
                toField.isEnabled = true
                roomFrom = currentRoom
            } else {
                selector.setEnabled(false, forSegmentAt: 0)
                selector.selectedSegmentIndex = 1
                toField.isEnabled = false
                roomFrom = nil
            }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // подготовка к переходу. передадим здесь данные
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case "openSearchFrom":
            let searchRouteController = segue.destination as! SearchRouteViewController
            searchRouteController.triggeredTextField = "FROM"
            searchRouteController.delegate = delegate
        case "openSearchTo":
            let searchRouteController = segue.destination as! SearchRouteViewController
            searchRouteController.triggeredTextField = "TO"
            searchRouteController.currentRoom = roomFrom
            searchRouteController.delegate = delegate
        case .none:
            break
        case .some(_):
            break
        }
        
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        
        if !textField.isEnabled {return false} // если редактирование запрещено
        
        print ("textFieldShouldBeginEditing")
        switch textField.tag {
            case 1:
                performSegue(withIdentifier: "openSearchFrom", sender: self)
            case 2:
                performSegue(withIdentifier: "openSearchTo", sender: self)
            default: break
        }
        
        
        return false
        
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol FinderInsideDelegate: NSObjectProtocol {
    //"событие"
    func newSearch(dismissController: Bool, fromId: String, ToId: String)
    func newSearchPoi (dismissController: Bool, fromRoomId: String, ToId: String)
    func continueNavigating()
    func interruptNavigating()
    func tryBuildingPath(roomId: String)
    func changeFloorLabel(floorNum: Int)
    func findDistanceFromRoomToRoom  (fromRoomId: String, toRoomId: String) -> Double
    func findDistanceFromRoomToPoi  (fromRoomId: String, toPoiId: String) -> Double
    func setCentrateButtonAvailiable (availiable: Bool)
}
    
