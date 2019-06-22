//
//  ClassViewController.swift
//  RealmEx
//
//  Created by 津吹陸 on 2019/06/16.
//  Copyright © 2019 津吹陸. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ClassViewController: UIViewController {
    
    var clas : Int?
    var selectedjujugyou = Day()
    let realm = try! Realm()
    var jugyou_names = "suugaku"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func button1(_ sender: Any) {
        //何回目の授業かを代入
        clas = 1
        selectedjujugyou = clasPhoto()
        performSegue(withIdentifier: "toViewController",sender: nil)
    }
    
    @IBAction func button2(_ sender: Any) {
        clas = 2
        selectedjujugyou = clasPhoto()
        performSegue(withIdentifier: "toViewController",sender: nil)
    }
    @IBAction func button3(_ sender: Any) {
        clas = 3
        selectedjujugyou = clasPhoto()
        performSegue(withIdentifier: "toViewController",sender: nil)
    }
    
    @IBAction func button4(_ sender: Any) {
        clas = 4
        selectedjujugyou = clasPhoto()
        performSegue(withIdentifier: "toViewController",sender: nil)
    }
    @IBAction func button5(_ sender: Any) {
        clas = 5
        selectedjujugyou = clasPhoto()
        performSegue(withIdentifier: "toViewController",sender: nil)
    }
    @IBAction func button6(_ sender: Any) {
        clas = 6
        selectedjujugyou = clasPhoto()
        performSegue(withIdentifier: "toViewController",sender: nil)
    }
    @IBAction func button7(_ sender: Any) {
        clas = 7
        selectedjujugyou = clasPhoto()
        performSegue(withIdentifier: "toViewController",sender: nil)
    }
    @IBAction func button8(_ sender: Any) {
        clas = 8
        selectedjujugyou = clasPhoto()
        performSegue(withIdentifier: "toViewController",sender: nil)
    }
    @IBAction func button9(_ sender: Any) {
        clas = 9
        selectedjujugyou = clasPhoto()
        performSegue(withIdentifier: "toViewController",sender: nil)
    }
    @IBAction func button10(_ sender: Any) {
        clas = 10
        selectedjujugyou = clasPhoto()
        performSegue(withIdentifier: "toViewController",sender: nil)
    }
    @IBAction func button11(_ sender: Any) {
        clas = 11
        selectedjujugyou = clasPhoto()
        performSegue(withIdentifier: "toViewController",sender: nil)
    }
    @IBAction func button12(_ sender: Any) {
        clas = 12
        selectedjujugyou = clasPhoto()
        performSegue(withIdentifier: "toViewController",sender: nil)
    }
    @IBAction func button13(_ sender: Any) {
        clas = 13
        selectedjujugyou = clasPhoto()
        performSegue(withIdentifier: "toViewController",sender: nil)
    }
    @IBAction func button14(_ sender: Any) {
        clas = 14
        selectedjujugyou = clasPhoto()
        performSegue(withIdentifier: "toViewController",sender: nil)
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toViewController") {
            let mainVC: ViewController = (segue.destination as? ViewController)!
            
            mainVC.jugyou = selectedjujugyou
            mainVC.ids = clas
        }
    }
    
    func clasPhoto() -> Day {
        if let Day1 = realm.object(ofType: Day.self, forPrimaryKey: jugyou_names){
            return Day1
        } else {
            let photo1 = Day()
            photo1.jugyou_name = jugyou_names
            try! realm.write {
                realm.add(photo1)
            }
            return photo1
        }
    }
}
