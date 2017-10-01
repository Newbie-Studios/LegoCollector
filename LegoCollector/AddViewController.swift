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
    @IBOutlet weak var addUpdateButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var lego : Lego? = nil //Create a variable which we can use in our viewDidLoad to populate the Lego screen
    
    
    var imagePicker = UIImagePickerController() //create variable to use as an image picker

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self //delegates are something that objects use to pull information they need
        
        if lego != nil {
            imageView.image = UIImage(data: lego!.image as! Data) //this will load this new VC but with different options in there.
            nameField.text = lego!.name
            codeField.text = lego!.code
            addUpdateButton.setTitle("Update", for: .normal) //this will change the button title to say Update and not Add
            
        } else {
            deleteButton.isHidden = true //hides the delete button if it is a new entry
        }
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
         imagePicker.sourceType = .camera
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
        
        if lego != nil { //IF THERE IS ALREADY SOMETHING IN CORED DATA (SO CLICKED) THEN JUST UPDATE,ELSE ADD NEW STUFF
            lego!.name = nameField.text //adds name
            lego!.code = codeField.text //adds code
            lego!.image = UIImageJPEGRepresentation(imageView.image!, 0.5) //we need to convert the image into NSData so we can add it to core data. Can either turn it into a png or jpg. We add the optional on the end of image!
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //this is the standard code to add the context for the core data
            let lego = Lego(context: context) //
            lego.name = nameField.text //adds name
            lego.code = codeField.text //adds code
            
            lego.image = UIImageJPEGRepresentation(imageView.image!, 0.5)//we need to convert the image into NSData so we can add it to core data. Can either turn it into a png or jpg. We add the optional on the end of image!
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext() //saves the context
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) { //this is what happens when we select the delete button
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(lego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext() //saves the context
        navigationController!.popViewController(animated: true)
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
