//
//  MainTabBarController.swift
//  TodayFocus
//
//  Created by aloha on 16/8/15.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    //json对应的数组
    private var array:Array<Dictionary<String,String>>?{
    
        get{
            let path = NSBundle.mainBundle().pathForResource("Ctrl", ofType: "json")
            
            var myArray: Array<Dictionary<String,String>>? = nil
            
            if let filePath = path{
            let data = NSData(contentsOfFile: filePath)
            
            if let jsonData = data{
            
                do{
                    let jsonValue = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
                    if jsonValue.isKindOfClass(NSArray.self){
                        myArray = jsonValue as? Array<Dictionary<String,String>>
                    
                    
                    }
                    
                }catch{
                    print(error)
                    return nil
                
                }
            
            
            
                }
            }
            return myArray
        }
    }
    
    
    
    func creatCtrl(){
    
        var ctrlNames = [String]()
        if let tmpArray = self.array{
            for i in tmpArray{
                let name = i["ctrlName"]
                ctrlNames.append(name!)
            
            }
        }else{
        
            
        
        }
        var vCtrlArray = Array<UINavigationController>()
        for i in 0..<ctrlNames.count{
            let ctrlName = "TodayFocus."+ctrlNames[i]
            let cls = NSClassFromString(ctrlName) as! UIViewController.Type
            let ctrl = cls.init()
            
            //导航
            let navCtrl = UINavigationController(rootViewController: ctrl)
            vCtrlArray.append(navCtrl)
        }
        
        self.viewControllers = vCtrlArray
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.creatCtrl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
