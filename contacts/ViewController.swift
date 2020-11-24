//
//  ViewController.swift
//  contacts
//
//  Created by Alua Zhakieva on 11/24/20.
//  Copyright © 2020 Alua Zhakieva. All rights reserved.
//

import UIKit
import ContactsUI

class ViewController: UIViewController {

    let contactsController = CNContactPickerViewController()
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectedImage: UIImageView!
    
    @IBAction func getNumber(_ sender: Any) {
        contactsController.delegate = self
        self.present(contactsController, animated: true, completion: nil)
    }
    
    @IBAction func pictureGet(_ sender: Any) {
        self.chooseDir()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController : CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        print("Phone number: \(contact.phoneNumbers[0].value.stringValue)")
        print("Name: \(contact.givenName) \(contact.familyName)")
        self.phoneLabel.text = contact.phoneNumbers[0].value.stringValue
        self.nameLabel.text = "\(contact.givenName) \(contact.familyName)"
    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseDir() {
        let libraryAction = UIAlertAction(title: "Choose from Library", style: .default) { (action) in
            self.showImage(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Choose from Camera", style: .default) { (action) in
            self.showImage(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        AlertService.showAlert(style: .actionSheet, title: "Choose image from:", message: nil, actions: [libraryAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImage(sourceType: UIImagePickerController.SourceType) {
        let imagesController = UIImagePickerController()
        imagesController.delegate = self
        imagesController.sourceType = sourceType
        present(imagesController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage.image = editedImage
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}
