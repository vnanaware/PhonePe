//
//  FollowesFollowingScreen.swift
//  PhonePe
//
//  Created by IBS on 7/17/19.
//  Copyright © 2019 IBS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FFUserCell: UITableViewCell {
    
    @IBOutlet var imgIcon:UIImageView!
    
    @IBOutlet var lblUserName:UILabel!
    @IBOutlet var btnGit_Url:UIButton!
    @IBOutlet var btnFollowers:UIButton!
    @IBOutlet var btnFollowing:UIButton!
}


class FollowesFollowingScreen: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tblFF_List:UITableView!
    @IBOutlet var viewFor_NoData:UIView!
    
    var strTitle=""
    
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialUI()
        // Do any additional setup after loading the view.
    }

    //MARK: Load Initial UI
    func loadInitialUI()
    {
        
        if appDelegate.isConnected {
            loadFollowerFollowingDataAPI()
        }
        else
        {
            showAlert("", message: vAlertMessageInvalidCredential, buttonTitle: "Ok")
        }
        
        tblFF_List.tableFooterView=UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.title = appDelegate.strFF_Title
    }
    
    //MARK:UITableView Delegate & DataSource declarations here
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrRes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:FFUserCell = self.tblFF_List.dequeueReusableCell(withIdentifier: "cell") as! FFUserCell
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        
        let prof_Data=arrRes[indexPath.row]
        print(prof_Data)
        
        var str_ImgURL=""
        str_ImgURL=prof_Data["avatar_url"] as! String
        cell.imgIcon.frame=CGRect(x: 15, y: cell.contentView.frame.height/2-25, width: 50, height: 50)
        //cell.imgIcon.layer.cornerRadius=4
         cell.imgIcon.layer.cornerRadius=cell.imgIcon.frame.width/2
         cell.imgIcon.contentMode = .scaleAspectFit
         cell.imgIcon.clipsToBounds=true
        
        cell.imgIcon.sd_setImage(with: URL(string: str_ImgURL), placeholderImage: UIImage(named: "icon_Profile"))
        
        
        cell.lblUserName.text=prof_Data["login"] as? String
        cell.btnGit_Url.tag=indexPath.row
        cell.btnFollowers.tag=indexPath.row
        cell.btnFollowing.tag=indexPath.row
        
        cell.btnGit_Url.addTarget(self, action: #selector(btnViewOnSitePressed(sender:)), for: .touchUpInside)
        cell.btnFollowing.addTarget(self, action: #selector(btnViewFollowingPressed(sender:)), for: .touchUpInside)
        cell.btnFollowers.addTarget(self, action: #selector(btnViewFollowersPressed(sender:)), for: .touchUpInside)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.title = ""
        let prof_Detail:Profile_DetailsScreen=storyboard?.instantiateViewController(withIdentifier: "prof_detail") as! Profile_DetailsScreen
        let prof_Data=arrRes[indexPath.row]
        appDelegate.strUserName=prof_Data["login"] as! String
        self.navigationController?.pushViewController(prof_Detail, animated: true)
    }
    
    //MAR: UIButton pressed delegate declarations
    @objc func btnViewFollowingPressed(sender:UIButton)
    {
        var row=Int()
        row=sender.tag
 
        let prof_Data=arrRes[row]
        appDelegate.strUserName=prof_Data["login"] as! String
        appDelegate.strFF_Title="Following"
        self.title="Following"
        appDelegate.strFF = "following"
        loadFollowerFollowingDataAPI()
    }
 
    @objc func btnViewFollowersPressed(sender:UIButton)
    {
        var row=Int()
        row=sender.tag
 
        let prof_Data=arrRes[row]
        appDelegate.strUserName=prof_Data["login"] as! String
        appDelegate.strFF_Title="Followers"
        self.title="Followers"
        appDelegate.strFF="followers"
        loadFollowerFollowingDataAPI()
    }
 
    @objc func btnViewOnSitePressed(sender:UIButton)
    {
        var row=Int()
        row=sender.tag
 
        let prof_Data=arrRes[row]
        let strHtml=prof_Data["html_url"]
        if let url = URL(string: strHtml as! String) {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            }
        }
 }
    
    //MARK: Load search API
    func loadFollowerFollowingDataAPI() {
        
       showSpinner("Loading...")
       let urlString = vAPIBaseURL+"users/\(appDelegate.strUserName)/\(appDelegate.strFF)"
        
        Alamofire.request(urlString).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar.arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {

                    self.tblFF_List.reloadData()
                    self.viewFor_NoData.isHidden=true
                }
                else
                {
                    self.viewFor_NoData.isHidden=false
                }
                
                dismissSpinner()
            }
        }
        
    }       
        
}
