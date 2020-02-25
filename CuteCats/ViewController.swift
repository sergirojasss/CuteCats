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
        
        self.loadData()
    }
    
    func loadData() {
        DispatchQueue.global(qos: .userInteractive).async {
            CatController.getCats { (cats) in
                //The threads stuff: Checkd and the response of Alamofire, it's on the main thread, so this callback, its executed on the main thread
                self.cats = cats
                self.collectionView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        self.dict.removeAll()
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
            cell.catImageView.image = UIImage(named: "placeholder")

            let cat: Cat = cats[indexPath.row]
            self.show(view: cell.catImageView)

            cell.setLables(cat: cat)

            if let image = self.dict[cat.id] { // image stored into the dictionary
                cell.catImageView.image = image
                self.hide(view: cell.catImageView)
            } else { // have to download image
                cell.catImageView.downloaded(from: cat.link) { (image) in
                    self.dict[cat.id] = image
                    if collectionView.indexPathsForVisibleItems.contains(indexPath) {
                        cell.catImageView.image = image
                        self.hide(view: cell.catImageView)
                    } else {
                        collectionView.reloadItems(at: [indexPath])
                    }
                }
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
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cat = cats[indexPath.row]
//        print(cats[indexPath.row].link)
//    }
    
    //reload data when device rotates
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.reloadData()
    }
    
    //    - MARK: Progress hud
    
    func show(view: UIView) {
        hide(view: view)
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.isUserInteractionEnabled = false
        hud.show(animated: true)

    }
    
    func hide(view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }

}

