//
//  ViewController.swift
//  Stak Fantasy
//
//  Created by Admin on 20.10.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = loader()
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.hidesBackButton = true
        self.present(vc, animated: true)
    }


}

