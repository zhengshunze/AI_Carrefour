//
//  ChatViewController.swift
//  AI_Carrefour
//
//  Created by zeze on 2022/3/7.
//

import UIKit



class ChatViewController: UIViewController {
    
    
    
    @IBOutlet weak var userinfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      	
        //        userinfo.contentInset = UIEdgeInsets(top: 12, left: 5, bottom: 12, right: 5)
        
        userinfo.isEditable = false
        userinfo.isUserInteractionEnabled = false
        userinfo.layer.cornerRadius = 20
        userinfo.clipsToBounds = true
        
        userinfo.text = "您搜尋的商品為： "
        
    }
    @IBOutlet weak var buttonsStack: UIStackView!




    
    var i = 0
    @IBAction func test(_ sender: Any) {
         
        
                   let x:Int = 100 + (i % 4) * 60
                   let y:Int = 140 + (i / 4) * 60
            let buttonNumber:UIButton = UIButton(type: UIButton.ButtonType.system) as UIButton
                   //按鈕位置 大小
                   buttonNumber.frame = CGRect(x: x,y: y,width: 40, height: 35)
                   //文字顏色
            buttonNumber.setTitleColor(UIColor.white, for: UIControl.State.normal)
                   //按鈕背景
                   buttonNumber.backgroundColor = UIColor.black
                   //字型大小
                   buttonNumber.titleLabel?.font = UIFont(name: "System", size: 22.0)
                   //加入按鈕
                   view.addSubview(buttonNumber)
               
          i = i+1
          
        
    }
    
    
    
    @IBAction func goback(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
