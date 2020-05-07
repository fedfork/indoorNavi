////
////  FinderInsideViewController.swift
////  HamburgerMenuBlog
////
////  Created by EventUser on 10/02/2019.
////  Copyright © 2019 Erica Millado. All rights reserved.
////
//import UIKit
//import MapKit
//import CoreLocation
//
//class FinderInsideViewController: UIViewController, UITextFieldDelegate {
//    @IBOutlet weak var FromField: UITextField!
//
//    @IBOutlet weak var ToField: UITextField!
//
//    weak var delegate: FinderInsideDelegate?
//
//    @IBAction func Close(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        FromField.delegate = self
//        ToField.delegate = self
//        // Do any additional setup after loading the view.
//    }
//
//
//
//    @IBAction func FindWay(_ sender: Any) {
//        let from = FromField.text
//        let to = ToField.text
//        delegate?.newSearch(self, fromField: from!, ToField: to!)
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        dismiss(animated: true, completion: nil)
//    }
//
//
//    /*
//     // MARK: - Navigation
//
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destination.
//     // Pass the selected object to the new view controller.
//     }
//     */
//
//}
//
//protocol FinderInsideDelegate: NSObjectProtocol {
//    //"событие"
//    func newSearch(_ controller: FinderInsideViewController,  fromField: String, ToField: String)
//}
//
