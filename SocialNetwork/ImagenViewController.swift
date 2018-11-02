//
//  ImagenViewController.swift
//  SocialNetwork
//
//  Created by Jhosep Bazan on 2/11/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ImagenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var descripcionTextField: UITextField!
    @IBOutlet weak var elegirContactoButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func elegirContactoTapped(_ sender: Any) {
        elegirContactoButton.isEnabled = false
        let imagenesFolder = Storage.storage().reference().child("imagenes")
        let imagenData = UIImagePNGRepresentation(ImageView.image!)!
        
        imagenesFolder.child("\(NSUUID().uuidString).jpg").putData(imagenData, metadata: nil, completion: {(metada, error) in
            print("Intentando subir la imagen")
            if error != nil {
                print("Ocurrio un error:\(error)")
            }else{
                self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: nil)
            }
        })
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        ImageView.image = image
        ImageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
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
