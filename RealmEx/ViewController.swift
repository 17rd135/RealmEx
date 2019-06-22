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

//追加
class ViewController: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let realm = try! Realm()
    var ids: Int!
    var selectedImage : UIImage?
    var str : String?
    var namber : Int?
    var jugyou = Day()
    
    //collectionViewのセルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //指定された授業の回のデータを検索
        let Day1 = self.jugyou.dairys.filter("id == %@",self.ids)
        return Day1.count
    }
    
    //collectionViewのセルの中身
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let testCell:UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        // Tag番号を使ってImageViewのインスタンス生成
        let imageView = testCell.contentView.viewWithTag(1) as! UIImageView

        //指定された授業の回のデータを検索
        let Day1 = self.jugyou.dairys.filter("id == %@",self.ids)
        let Url = Day1[indexPath.row].url
        //URLから画像のイメージを取得
        let image = loadImageFromPath(path: Url)
        imageView.image = image
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            // section数は１つ
            return 1
        }
        
        return testCell
    }
    
    //cellの画像が押されたとき、違う画面に行き画像を拡大させる
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        str = self.jugyou.dairys.filter("id == %@",self.ids)[indexPath.row].url
        namber = indexPath.row
        selectedImage = loadImageFromPath(path:  str!)
        if selectedImage != nil {
            // SubViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "toSubViewController",sender: nil)
        }
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toSubViewController") {
            let subVC: SubViewController = (segue.destination as? SubViewController)!
            // SubViewControllerのselectedImgに選択された画像を設定する
            subVC.selectedImg = selectedImage
            subVC.selectedStr = str
            subVC.selectedList = jugyou
            subVC.selectedNamber = namber
            subVC.clas = ids
        }
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewDidDisappear(animated)
        //collectionViewに反映させる
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 写真を保存する（カメラロールから写真を選択する処理）
    @IBAction func saveButton(_ sender: Any) {
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
    
    //前の画面に戻る
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 写真を選んだ後に呼ばれる処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let data1 = Diary()
        //画像のイメージを取得
        let img = info[.originalImage] as! UIImage
        
        //画像のURLを取得
        if let Url = info[.imageURL] as? NSURL {
            data1.id = ids
            data1.url = Url.lastPathComponent!
            //ファイルに書き込む
            if saveImage(image: img, path: data1.url) {
                try! realm.write() {
                    //受け取った授業名のlistに追加
                    jugyou.dairys.append(data1)
                }
            }
        }
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
}
