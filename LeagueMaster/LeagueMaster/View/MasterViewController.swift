//
//  MasterViewController.swift
//  LeagueMaster
//
//  Created by Ying Yang on 3/27/19.
//  Copyright © 2019 Ying Yang. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    @IBOutlet weak var championCollectionView: UICollectionView!
    let viewModel = AllChampionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
        splitViewController?.preferredDisplayMode = .allVisible
        setUpViews()
        viewModel.getAllChampions(onSuccess: {
            DispatchQueue.main.async {
                self.championCollectionView.reloadData()
            }
        }) { (error) in
            print("error")
        }
        // Do any additional setup after loading the view.
    }
    
//    @IBAction func show(_ sender: Any) {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController")
//        splitViewController?.showDetailViewController(vc, sender: nil)
//    }
    
    private func setUpViews(){
        championCollectionView.register(UINib(nibName: "ChampionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ChampionCollectionViewCell")
        championCollectionView.delegate = self
        championCollectionView.dataSource = self
    }
    
    
}

extension MasterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.allChampions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChampionCollectionViewCell", for: indexPath) as! ChampionCollectionViewCell
        let champ = viewModel.allChampions[indexPath.row]
        cell.configureCell(name: champ.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.championCollectionView.frame.width - 20 * 3) / 2
        let height = width * 1.82 + 24
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    
}


extension MasterViewController: UISplitViewControllerDelegate {
    // initially show the MasterViewController instead of DetailViewController
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

