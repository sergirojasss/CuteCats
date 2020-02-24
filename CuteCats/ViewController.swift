//
//  ViewController.swift
//  CuteCats
//
//  Created by Sergi Rojas on 24/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var cats: [Cat] = []
    var dict: [IndexPath: UIImage] = [:]
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        CatController.getCats { (cats) in
            self.cats = cats
            self.collectionView.reloadData()
        }
    }
    
//    - MARK: Collection view methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: CatsCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatsCell", for: indexPath) as? CatsCVCell {
            if let image = self.dict[indexPath] {
                cell.catImageView.image = image
            } else {
                cell.catImageView.downloaded(from: cats[indexPath.row].link)
                if let image: UIImage = cell.catImageView.image {
                    self.dict[indexPath] = image
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}

