//
//  ViewController.swift
//  gm-commit-fetcher
//
//  Created by Cole Charles on 10/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImage?.layer.cornerRadius = 5;
        logoImage?.clipsToBounds = true;
        // Do any additional setup after loading the view.
       // self.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }
}

