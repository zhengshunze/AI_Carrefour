//
//  poprecording.swift
//  AI_Carrefour
//
//  Created by zeze on 2022/3/2.
//


import UIKit
import AVFoundation


class poprecording: UIViewController {
    
    var delegate: controlaudio?
   
    @IBOutlet weak var recordingGIF: UIImageView!
    
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    var mytext = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = mytext
        popupView.layer.cornerRadius =	 10
        popupView.layer.masksToBounds = true

        // load a GIF
        recordingGIF.loadGif(name: "wave4")
        // Do any additional setup after loading the view.

    }
    
    
    
    @IBAction func test(_ sender: Any) {
       
            
       
    }
    
    @IBAction func closepopup(_ sender: Any) {
        delegate?.stopRecordAudio()
        
        //let parentVC = presentingViewController
        dismiss(animated: true) {
//            let vc = self.storyboard!.instantiateViewController (withIdentifier: "popchat")
//            let ChatViewController = self.storyboard?.instantiateViewController(withIdentifier: "popchat") as! ChatViewController
//            ChatViewController.text = "HI!"
       // parentVC?.present(vc, animated: true, completion: nil)
        
           }
        }
    
    @IBAction func go(_ sender: Any) {
      
    
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? ChatViewController {
//            destination.mytext2 = label.text!
//
//        }
    }
