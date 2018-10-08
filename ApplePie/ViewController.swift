//
//  ViewController.swift
//  ApplePie
//
//  Created by Charles Martin Reed on 10/8/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- IBOulets
    @IBOutlet weak var treeImageVIew: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: IBActions
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false // works without typecasting because this is explictly set to UIButton
    }
    


}

