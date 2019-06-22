//
//  SubViewController.swift
//  RealmEx
//
//  Created by 津吹陸 on 2019/06/15.
//  Copyright © 2019 津吹陸. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class SubViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var selectedImg: UIImage!
    var selectedStr: String!
    var selectedList = Day()
    var selectedNamber: Int!
    var clas: Int!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = selectedImg
        // 画像のアスペクト比を維持しUIImageViewサイズに収まるように表示
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    @IBAction func backView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //写真を消す
    @IBAction func deletePhoto(_ sender: Any) {
        let Day1 = self.selectedList.dairys.filter("id == %@",self.clas)
        try! realm.write() {
            realm.delete(Day1[selectedNamber])
        }
        deleteFile(path: selectedStr)
        self.dismiss(animated: true, completion: nil)
    }
}
