//
//  SnapsViewController.swift
//  SocialNetwork
//
//  Created by Jhosep Bazan on 2/11/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var snaps : [Snap] = []
    
    @IBAction func cerrarSesionTapped(_ sender: Any) {
            dismiss(animated: true, completion: nil)
            print("Sesion cerrada")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate = self
         
        FIRDatabase.database().reference().child("usuarios").child((FIRAuth.auth()?.currentUser!.uid)!).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot) in
                let snap = Snap()
                
                snap.imagenURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
                snap.from = (snapshot.value as! NSDictionary)["from"] as! String
                snap.descrip = (snapshot.value as! NSDictionary)["description"] as! String
                snap.id = snapshot.key
                snap.imagenID = (snapshot.value as! NSDictionary)["imagenID"] as! String
                self.snaps.append(snap)
                self.tableView.reloadData()
            })
        FIRDatabase.database().reference().child("usuarios").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childRemoved, with: {(snapshot) in
            var iterador = 0
            for snap in self.snaps{
                if snap.id == snapshot.key{
                    self.snaps.remove(at: iterador)
                }
                iterador += 1 
            }
            self.tableView.reloadData()
        })

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0 {
            return 1
        }else{
            return snaps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if snaps.count == 0 {
            cell.textLabel?.text = "No tienes Snaps 😪"
        }else{
            let snap = snaps[indexPath.row]
            cell.textLabel?.text = snap.from
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "versnapsegue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "versnapsegue" {
            let siguienteVC = segue.destination as! VerSnapViewController
            siguienteVC.snap = sender as! Snap
        }
    }

}
