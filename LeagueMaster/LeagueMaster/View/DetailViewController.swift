//
//  DetailViewController.swift
//  LeagueMaster
//
//  Created by Ying Yang on 3/27/19.
//  Copyright © 2019 Ying Yang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let viewModel = ChampionDetailsViewModel()
    private let spinner = LoadingSpinner()
    var champion: Champion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.show(in: self)
        fetchChampionDetail()
        // Do any additional setup after loading the view.
    }
    
    private func fetchChampionDetail(){
        guard let id = champion?.id else {return}
        viewModel.getChampionDetails(with: id, onSuccess: {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: { // delay only for testing the spinner
                print(self.viewModel.champion?.blurb)
                self.spinner.dismiss()
            })
        }) { (error) in
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.spinner.dismiss()
                self.showAlertWith(message: error?.localizedDescription ?? "Something went wrong")
            })
        }
    }
    
    
}

