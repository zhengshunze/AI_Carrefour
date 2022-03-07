//
//  ViewController.swift
//  AI_Carrefour
//
//  Created by zeze on 2022/3/2.
//

import UIKit
import AVFoundation



protocol controlaudio {
    func stopRecordAudio()
}

class ViewController: UIViewController,controlaudio {
    

    func stopRecordAudio()
    {
        guard audioRecorder != nil else {
            return
        }
        audioRecorder!.stop()
        print("停止錄音")
    }
    	
    let session = AVAudioSession.sharedInstance()
    // 錄音用
    var audioRecorder: AVAudioRecorder?
    // 播放用
    var audioPlayer: AVAudioPlayer?
    // 設定錄音檔路徑與檔名
    let tmpURL = URL(fileURLWithPath: NSTemporaryDirectory() + "audio.wav")
    	
    @IBOutlet weak var btnassistant: UIButton!
    
    @IBOutlet weak var btnscan: UIButton!
    
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
     
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        nc.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        print(tmpURL.absoluteString)
        // 設定錄音品質
        let audioSettings: [String : Any] = [AVFormatIDKey: Int(kAudioFormatLinearPCM),
                                           AVSampleRateKey: 44100.0,
                                           AVNumberOfChannelsKey: 1,
                                           AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue ]
        //let audioSettings = [
        //    AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC)
        // ]
        
    
            if (session.responds(to: #selector(AVAudioSession.requestRecordPermission(_:)))) {
                AVAudioSession.sharedInstance().requestRecordPermission({ [self](granted: Bool)-> Void in
                       if granted {
                           btnassistant.isUserInteractionEnabled=true
                           do {
                               try self.session.setCategory(.playAndRecord, mode: .measurement, options: [])
                               try self.session.setActive(true)
                               self.audioRecorder = try AVAudioRecorder(url: self.tmpURL, settings: audioSettings)
                           }
                           catch {

                               print("無法建立音訊session目錄！")
                           }
                       } else{
                           print("not granted")
                           btnassistant.isUserInteractionEnabled=false
                           _ = authorize_Audio()

                       }
                   })
               }
        
        
      
    }
    @objc func appMovedToBackground() {
        print("yap")
    }

    @objc func appMovedToForeground() {
        print("oops")
    }
    func authorize_Audio()->Bool{
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
             
            switch status {
            case .authorized:
                return true
                 
            case .notDetermined:
               
                AVCaptureDevice.requestAccess(for: AVMediaType.audio, completionHandler: {
                           (status) in
                           DispatchQueue.main.async(execute: { () -> Void in
                               _ = self.authorize_Audio()
                           })
                       })
                   default: ()
            DispatchQueue.main.async(execute: { () -> Void in
                let alertController = UIAlertController(title: "無法訪問您的麥克風",
                                                        message: "請到設置 -> 隱私 -> 麥克風 ，打開訪問權限",
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
            }
            return false
        }

    @IBAction func scanIngredient(_ sender: Any) {
        
       // _ = authorize_Camera()
        
        print("test")
    }
    
    
    
    
    
    
    
    @IBAction func recordAudio(_ sender: Any) {
        guard self.audioRecorder != nil else {
                      return
                  }
      
        if self.audioRecorder!.record() {
               
                print("開始錄音")
            }
        
        
    }
    
    

    
       
        
                 
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let destination = segue.destination as? poprecording	 {
               destination.delegate = self
           }
       }
  

    
      
    
}

