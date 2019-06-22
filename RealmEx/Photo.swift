//
//  Photo.swift
//  RealmEx
//
//  Created by 津吹陸 on 2019/06/21.
//  Copyright © 2019 津吹陸. All rights reserved.
//
import UIKit

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
    let DocumentsPath = fileInDocumentsDirectory(filename: path)
    do {
        try pngImageData!.write(to: URL(fileURLWithPath: DocumentsPath), options: .atomic)
    } catch {
        print(error)
        return false
    }
    return true
}

//指定したURLのfileを削除する
func deleteFile (path: String) {
    let DocumentsPath = fileInDocumentsDirectory(filename: path)
    do {
        try FileManager.default.removeItem(atPath: DocumentsPath)
    } catch {
        print("error")
    }
}

//入れたパスをURLにし、そのURLから写真を取り出す
func loadImageFromPath(path: String) -> UIImage? {
    let DocumentsPath = fileInDocumentsDirectory(filename: path)
    let image = UIImage(contentsOfFile: DocumentsPath)
    if image == nil {
        print("missing image at: \(DocumentsPath)")
    }
    return image
}
