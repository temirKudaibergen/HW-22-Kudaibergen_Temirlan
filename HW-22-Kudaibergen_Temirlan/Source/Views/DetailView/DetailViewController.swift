//
//  DetailViewController.swift
//  HW-22-Kudaibergen_Temirlan
//
//  Created by Темирлан Кудайберген on 13.06.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var detailView = DetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = detailView
        let button = UIBarButtonItem(customView: detailView.editSaveButton )
        navigationItem.rightBarButtonItem = button
    }
}
