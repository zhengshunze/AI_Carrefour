//
//  ChatViewController.swift
//  AI_Carrefour
//
//  Created by zeze on 2022/3/7.
//

import UIKit



class ChatViewController: UIViewController {
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func goback(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
