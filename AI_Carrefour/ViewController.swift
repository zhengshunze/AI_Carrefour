//
//  ViewController.swift
//  AI_Carrefour
//
//  Created by zeze on 2022/3/2.
//

import UIKit
import AVFoundation
import googleapis

let SAMPLE_RATE = 16000


protocol controlaudio {
    func stopRecordAudio()
}

class ViewController: UIViewController,controlaudio,AudioControllerDelegate {

    var audioData: NSMutableData!
    
 
    func stopRecordAudio()
    {
        guard audioRecorder != nil else {
            return
        }
        audioRecorder!.stop()
        print("停止錄音")
        _ = AudioController.sharedInstance.stop()
        SpeechRecognitionService.sharedInstance.stopStreaming()
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
    
    
    @IBOutlet weak var lbresultwords: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioController.sharedInstance.delegate = self
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
        
        audioData = NSMutableData()
        
        _ = AudioController.sharedInstance.prepare(specifiedSampleRate: SAMPLE_RATE)
        SpeechRecognitionService.sharedInstance.sampleRate = SAMPLE_RATE
        _ = AudioController.sharedInstance.start()
        
        
        
    }
    func processSampleData(_ data: Data) {
        audioData.append(data)
        
        // We recommend sending samples in 100ms chunks
        let chunkSize: Int /* bytes/chunk */ = Int(
            0.1 /* seconds/chunk */
            * Double(SAMPLE_RATE) /* samples/second */
            * 2 /* bytes/sample */)
        
        if audioData.length > chunkSize {
            SpeechRecognitionService.sharedInstance.streamAudioData(
                audioData,
                completion: { [weak self] (response, error) in
                    guard let strongSelf = self else {
                        return
                    }
                    if let error = error {
                        strongSelf.lbresultwords.text = error.localizedDescription
                    } else if let response = response {
                        var finished = false
                        for result in response.resultsArray {
                            if let alternative = result as? StreamingRecognitionResult {
                                for a in alternative.alternativesArray {
                                    if let ai = a as? SpeechRecognitionAlternative {
                                        if alternative.isFinal {
                                            let someValue: String? = ai.transcript
                                            if let newValue = someValue {
                                                strongSelf.lbresultwords.text = "\(newValue)"
                                            }
                                           
                                            //print(ai.transcript)
                                            finished = true
                                        }
                                    }
                                }
                                if finished {
                                    strongSelf.stopRecordAudio()
                                }
                            }
                        }
                    }
                })
            self.audioData = NSMutableData()
            
        }
        
    }
    

    
       
        
                 
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let destination = segue.destination as? poprecording	 {
               destination.delegate = self
           }
       }
  

    
      
    
}

