//
//  ScanViewController.swift
//  AI_Carrefour
//
//  Created by zeze on 2022/3/5.
//

import UIKit
import PhotosUI

class ScanViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  
    @IBOutlet weak var closecamera: UIButton!
    let imagePicker  = UIImagePickerController()
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
      
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        super.viewDidLoad()
      
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "test", style: .plain, target: self,action: #selector(backViewBtnFnc))

    }
    
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            present(imagePicker, animated: true, completion: nil)
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    self.present(self.imagePicker, animated: true, completion: nil)
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            print("User do not have access to photo album.")
        case .denied:
            DispatchQueue.main.async(execute: { () -> Void in
                let alertController = UIAlertController(title: "無法訪問您的相簿",
                                                        message: "請到設置 -> 隱私 -> 相簿 ，打開訪問權限",
                                                        preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title:"關閉", style: .cancel, handler:{ action in exit(0) })
                
                let settingsAction = UIAlertAction(title:"設定", style: .default, handler: {
                    (action) -> Void in
                    let url = URL(string: UIApplication.openSettingsURLString)
                    if let url = url, UIApplication.shared.canOpenURL(url) {
                        if #available(iOS 10, *)
                        {
                            UIApplication.shared.open(url, options: [:],
                                                      completionHandler: {
                                (success) in
                            })
                        } else {
                            UIApplication.shared.openURL(url)
                            
                        }
                    }
                    
                })
                
                alertController.addAction(cancelAction)
                alertController.addAction(settingsAction)
                
                self.present(alertController, animated: true, completion: nil)
            })
            
        case .limited:
            print("limit")
        @unknown default:
            print("limit")
        }
    }
    
    
    
    
    @objc func backViewBtnFnc(){
           self.navigationController?.popViewController(animated: true)
       }
    @IBAction func test(_ sender: Any) {

        getPhoto()
        

    }

    func getPhoto(){
        
        self.imagePicker.sourceType = .camera
        self.present(self.imagePicker, animated: true, completion: nil)
          }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
           img.image = pickedImage
           dismiss(animated: true, completion: nil)
       }
    
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo Info:[UIImagePickerController.InfoKey: Any]) {
//        dismiss(animated: true, completion: nil)
//
//        guard let image = Info[.originalImage]as? UIImage else{
//
//            print("image not found")
//            return
//        }
//
//        var _: UIImageView = {
//                let imageView = UIImageView(frame: .zero)
//                imageView.image = image
//                imageView.contentMode = .scaleToFill
//                imageView.translatesAutoresizingMaskIntoConstraints = false
//                return imageView
//            }()
//        img.image = image
//    }
    
//    func imagePickerController(_ picker:UIImagePickerController){
//        dismiss(animated: true, completion: nil)
//    }


    @IBAction func closecamera(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


    @IBAction func addphoto(_ sender: Any) {
        checkPermission()
    }
    
    
    
    
    
}
