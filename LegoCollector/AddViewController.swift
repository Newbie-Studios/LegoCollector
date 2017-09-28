//
//  AddViewController.swift
//  LegoCollector
//
//  Created by Jamie Roberts on 26/09/2017.
//  Copyright © 2017 Newbie-Studios. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var codeField: UITextField!
    
    var imagePicker = UIImagePickerController() //create variable to use as an image picker
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self //delegates are something that objects use to pull information they need
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary //source of image picker. This will allow us to select from camera roll
        self.present(imagePicker, animated: true, completion: nil) //allows us to present another view controller (in this case UIImagePicker and can have completion as nil as it's an optional
    }
    
   internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) { //This has now created a dictionary which we can use in the funtion
        let image = info [UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //this is the standard code to add the context for the core data
        let lego = Lego(context: context) //
        lego.name = nameField.text //adds name
        lego.code = codeField.text //adds code
        lego.image = UIImagePNGRepresentation(imageView.image!) //we need to convert the image into NSData so we can add it to core data. Can either turn it into a png or jpg. We add the optional on the end of image!
        (UIApplication.shared.delegate as! AppDelegate).saveContext() //saves the context
        navigationController!.popViewController(animated: true)
        
        
        
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
