
import UIKit


protocol controlaudio {
    func imagePickerController()
}

class ScanViewController:  UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

  
    @IBOutlet weak var closecamera: UIButton!
    
//    class ScanViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
//    @IBOutlet weak var imageView:UIImageView!
    
//    let imagePicker = UIImagePickerController()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        checkPermission()//呼叫funtion放在裡面
//        imagePicker.delegate = self
//        imagePicker.allowsEditing = true
//}
//詢問存取權是否可以進行
//func checkPermission() {
//    let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
//    switch photoAuthorizationStatus {
//    case .authorized:
//        present(imagePicker, animated: true, completion: nil)
//        print("Access is granted by user")
//    case .notDetermined:
//        PHPhotoLibrary.requestAuthorization({
//            (newStatus) in
//            print("status is \(newStatus)")
//            if newStatus ==  PHAuthorizationStatus.authorized {
                /* do stuff here */
//                self.present(self.imagePicker, animated: true, completion: nil)
//                print("success")
//            }
//        })
//        print("It is not determined until now")
//    case .restricted:
//         same same
//        print("User do not have access to photo album.")
//    case .denied:
        // same same
//        print("User has denied the permission.")
//    }
//}

//@IBAction func didTapAddPhotoButton(_ sender: Any) {
    
    
//    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
//    alert.addAction(UIAlertAction(title: "相機膠卷", style: .default, handler: { (button) in
//        self.imagePicker.sourceType = .photoLibrary
//        self.present(self.imagePicker, animated: true, completion: nil)
//    }))
    
//    alert.addAction(UIAlertAction(title: "拍照", style: .default, handler: { (button) in
//        self.imagePicker.sourceType = .camera
//        self.present(self.imagePicker, animated: true, completion: nil)
//    }))
    
//    alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
    
//    present(alert, animated: true, completion: nil)
//}

//func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//    guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
//    imageView.image = pickedImage
    
//    dismiss(animated: true, completion: nil)
//}

//}

        
    
    
    
    
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let imagePicker = UIImagePickerController()
            
            override func viewDidLoad() {
                super.viewDidLoad()
                checkPermission()//呼叫funtion放在裡面
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
        
    }
//詢問存取權是否可以進行
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
                 same same
                print("User do not have access to photo album.")
            case .denied:
                 same same
                print("User has denied the permission.")
            }
        }

    
        
    @objc func backViewBtnFnc(){
           self.navigationController?.popViewController(animated: true)
       }
    @IBAction func didTapAddPhotoButton(_ sender: Any) {
      
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
