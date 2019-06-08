//
//  ViewController.swift
//  RealmEx
//
//  Created by 津吹陸 on 2019/05/18.
//  Copyright © 2019 津吹陸. All rights reserved.
//

import UIKit
import Photos //追加
import Realm
import RealmSwift

//UIImagePickerControllerDelegate, UINavigationControllerDelegateを追加
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // カメラロールから写真を選択する処理
    @IBAction func pictureSetting(_ sender: Any) {
        // 写真を選ぶビュー
        let ipc = UIImagePickerController()
        ipc.delegate = self
        // 写真の選択元をカメラロールにする
        ipc.sourceType = .photoLibrary
        //編集を可能にする
        ipc.allowsEditing = true
        // ビューに表示
        self.present(ipc,animated: true, completion: nil)
    }
    
    
    // 写真を選んだ後に呼ばれる処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let realm = try! Realm()
        let data1 = Diary()
    
        // 選択した写真を取得する
        let img = info[.originalImage] as! UIImage
        // 選択した写真のURLを取得する
        if let Url = info[.imageURL] as? NSURL {
            let lastUrl = Url.lastPathComponent
            data1.url = self.fileInDocumentsDirectory(filename: lastUrl!)
            //realmに保存
            try! realm.write() {
                realm.add(data1)
            }
            //ファイルに書き込む
            if saveImage(image: img, path: data1.url) {
                let image = loadImageFromPath(path: data1.url)
                self.imageView.image = image
            }
        }
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
        return documentsURL
    }
    
    // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
    func fileInDocumentsDirectory(filename: String) -> String {
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL!.path
    }

    //写真を指定したURLに保存する
    func saveImage (image: UIImage, path: String ) -> Bool {
        let pngImageData = image.pngData()
        do {
            try pngImageData!.write(to: URL(fileURLWithPath: path), options: .atomic)
        } catch {
            print(error)
            return false
        }
        return true
    }
    
    //入れたパスをURLにし、そのURLから写真を取り出す
    func loadImageFromPath(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            print("missing image at: \(path)")
        }
        return image
    }
}


