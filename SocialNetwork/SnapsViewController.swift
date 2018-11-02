//
//  SnapsViewController.swift
//  SocialNetwork
//
//  Created by Jhosep Bazan on 2/11/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    @IBAction func cerrarSesionTapped(_ sender: Any) {
            dismiss(animated: true, completion: nil)
            print("Sesion cerrada")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
