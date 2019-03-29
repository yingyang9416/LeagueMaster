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
    private let viewModel = AllChampionsViewModel()
    private let spinner = LoadingSpinner()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        fetchAllChampions()
        spinner.show(in: self)
    }
    
    @objc private func fetchAllChampions(){
        viewModel.getAllChampions(onSuccess: {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: { // delay only for showing the spinner
                self.championCollectionView.reloadData()
                self.spinner.dismiss()
                self.refreshControl.endRefreshing()
            })
        }) { (error) in
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.spinner.dismiss()
                self.refreshControl.endRefreshing()
                self.showAlertWith(message: error?.localizedDescription ?? "Something went wrong")
            })
        }
    }
    
    private func setUpViews(){
        splitViewController?.delegate = self
        splitViewController?.preferredDisplayMode = .allVisible
        championCollectionView.register(UINib(nibName: "ChampionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ChampionCollectionViewCell")
        championCollectionView.delegate = self
        championCollectionView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(fetchAllChampions), for: .valueChanged)
        if #available(iOS 10.0, *){
            championCollectionView.refreshControl = refreshControl
        }else{
            championCollectionView.addSubview(refreshControl)
        }
    }
    
    
}

extension MasterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.allChampions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChampionCollectionViewCell", for: indexPath) as! ChampionCollectionViewCell
        let champ = viewModel.allChampions[indexPath.row]
        cell.configureCell(champion: champ)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let championVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        championVC.champion = viewModel.allChampions[indexPath.row]
        splitViewController?.showDetailViewController(championVC, sender: nil)
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

