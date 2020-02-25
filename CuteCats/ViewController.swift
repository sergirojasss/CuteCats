//
//  ViewController.swift
//  CuteCats
//
//  Created by Sergi Rojas on 24/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var cats: [Cat] = []
    var dict: [String: UIImage] = [:]
    
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
            
            cell.catImageView.image = nil
            show(view: cell.catImageView)
            
            let cat: Cat = cats[indexPath.row]
            cell.title.text = cat.title
            cell.numOfViews.text = String(cat.views)

            if let image = self.dict[cat.id] {
                cell.catImageView.image = image
                hide(view: cell.catImageView)
            } else {
                cell.catImageView.downloaded(from: cat.link) { (image) in
                    cell.catImageView.image = image
                    self.hide(view: cell.catImageView)
                    self.dict[cat.id] = image
                }
                cell.layer.shouldRasterize = true
                cell.layer.rasterizationScale = UIScreen.main.scale
                
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width / 2, height: 300)
    }
    
//    - MARK: Progress hud
    
    func show(view: UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.isUserInteractionEnabled = false
        hud.show(animated: true)

    }
    
    func hide(view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
}

