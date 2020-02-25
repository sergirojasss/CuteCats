//
//  ViewController.swift
//  CuteCats
//
//  Created by Sergi Rojas on 24/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cats: [Cat] = []
    var dict: [String: UIImage] = [:]
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.white
        
        self.title = NSLocalizedString("cats", comment: "")
        
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
            
            let cat: Cat = cats[indexPath.row]
            show(view: cell.catImageView)

            cell.setLables(cat: cat)

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
        let width = (self.collectionView.frame.width - 5) / 2 // 5 min space btw cells
        return CGSize(width: width, height: 300)
//        return UICollectionViewFlowLayout.automaticSize
    }
    
    //reload data when device rotates
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.reloadData()
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

