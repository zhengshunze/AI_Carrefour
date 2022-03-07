//
//  ScanViewController.swift
//  AI_Carrefour
//
//  Created by zeze on 2022/3/5.
//

import UIKit

class ScanViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  
    @IBOutlet weak var closecamera: UIButton!
    
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhoto()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "test", style: .plain, target: self,action: #selector(backViewBtnFnc))

    }
    @objc func backViewBtnFnc(){
           self.navigationController?.popViewController(animated: true)
       }
    @IBAction func test(_ sender: Any) {
      
        getPhoto()
        //
        
    }
    
    func getPhoto(){
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerController.SourceType.camera
        picker.allowsEditing = false
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo Info:[UIImagePickerController.InfoKey: Any]) {
        dismiss(animated: true, completion: nil)

        guard let image = Info[.originalImage]as? UIImage else{
            
            print("image not found")
            return
        }
        
        var _: UIImageView = {
                let imageView = UIImageView(frame: .zero)
                imageView.image = image
                imageView.contentMode = .scaleToFill
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
            }()
        img.image = image
    }
    func imagePickerController(_ picker:UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func closecamera(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addphoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerController.SourceType.camera
        picker.allowsEditing = false
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    
    
    
    
}
