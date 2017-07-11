//
//  SortViewController.swift
//  TheStrew
//
//  Created by Shakti Pratap Singh on 11/07/17.
//  Copyright © 2017 Shakti Pratap Singh. All rights reserved.
//

import UIKit

class SortViewController: UIViewController {

    @IBOutlet weak var subView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subView.clipsToBounds = true
        subView.layer.cornerRadius = 15
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
