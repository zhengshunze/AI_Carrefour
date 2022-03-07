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
    override func viewDidLoad() {
        super.viewDidLoad()
      
        popupView.layer.cornerRadius =	 10
        popupView.layer.masksToBounds = true

        // load a GIF
        recordingGIF.loadGif(name: "wave4")
        // Do any additional setup after loading the view.

    }
    
    @IBAction func closepopup(_ sender: Any) {
        dismiss(animated: true	, completion: nil)
        delegate?.stopRecordAudio()
    }
        
}
