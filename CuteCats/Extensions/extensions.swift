//
//  extensions.swift
//  CuteCats
//
//  Created by Sergi Rojas on 24/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


extension UIImageView {
    
//    func setPlaceholder() {
//        self.image = UIImage(named: Constants.imagePlaceholder)
//    }
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: @escaping (_ success: UIImage) -> Void) {

        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
//                self.image = image
                completion(image)
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: @escaping (_ success: UIImage) -> Void) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode) { (image) in
            completion(image)
        }
    }
    
//    func saveOnDevice(fileName: String, image: UIImage) {
//        // get the documents directory url
//        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        // choose a name for your image
//        let fileName = fileName
//        // create the destination file url to save your image
//        let fileURL = documentsDirectory.appendingPathComponent(fileName)
//        // get your UIImage jpeg data representation and check if the destination file url already exists
//        if let data = image.jpegData(compressionQuality:  1.0),
//            !FileManager.default.fileExists(atPath: fileURL.path) {
//            do {
//                // writes the image data to disk
//                try data.write(to: fileURL)
//                print("file saved")
//            } catch {
//                print("error saving file:", error)
//            }
//        }
//
//    }
//
//    func getFromDevice(fileName: String) -> UIImage? {
//        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
//
//        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
//        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
//
//        if let dirPath = paths.first {
//            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent("\(fileName).png")
//            let image = UIImage(contentsOfFile: imageUrl.path)
//            return image
//
//        }
//        return nil
//    }
}
