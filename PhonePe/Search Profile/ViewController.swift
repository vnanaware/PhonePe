//
//  ViewController.swift
//  PhonePe
//
//  Created by IBS on 7/9/19.
//  Copyright © 2019 IBS. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class githubUsersCell: UITableViewCell {
    
    @IBOutlet var imgIcon:UIImageView!
    @IBOutlet var lblUserName:UILabel!
    @IBOutlet var btnGit_Url:UIButton!
    @IBOutlet var btnFollowers:UIButton!
    @IBOutlet var btnFollowing:UIButton!
}


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet var tblProfiles_List:UITableView!
    @IBOutlet var btnSearch:UIButton!
    @IBOutlet var txtSearch:UITextField!
    
    var arrProfil_List = [AllUserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        loadInitialUI()
        
        if appDelegate.isConnected
        {
            appDelegate.strSearch_text="torvalds"
            loadSearchUserAPI()
        }
        else
        {
            showAlert(vAlertTitleNetworkConnection, message: vAlertMessageNetworkConnection, buttonTitle: "Ok")
        }
    }

    
    //MARK: Load Initial UI
    func loadInitialUI()  {
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let pHolderFont=UIFont.init(name: "Avenir-Roman", size: 16)
        
        txtSearch.attributedPlaceholder = NSAttributedString(string:"Search...", attributes:[NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font :pHolderFont ?? 0])
        
        tblProfiles_List.tableFooterView=UIView()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.topItem?.title = "Search Github profiles"
    }
    
    //MARK: UIButton pressed delegate declarations here
    
    @IBAction func btnSearchPressed(_ sender: Any) {
    
        view.endEditing(true)
        appDelegate.isConnected=NetworkReachabilityManager()!.isReachable
        if appDelegate.isConnected
        {
            if txtSearch.text?.count ?? 0 > 0
            {
                appDelegate.strSearch_text=""
                appDelegate.strSearch_text=txtSearch.text!
                loadSearchUserAPI()
            }
            else
            {
                showAlert("", message: vAlertMessageInvalidCredential, buttonTitle: "Ok")
            }
        }
        else
        {
            showAlert(vAlertTitleNetworkConnection, message: vAlertMessageNetworkConnection, buttonTitle: "Ok")
        }
    }
    
    
    
    //MARK:UITableView Delegate & DataSource declarations here
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrProfil_List.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell:githubUsersCell = self.tblProfiles_List.dequeueReusableCell(withIdentifier: "userList") as! githubUsersCell
            cell.selectionStyle=UITableViewCell.SelectionStyle.none
   
            let Prof_Data=arrProfil_List[indexPath.row]
        
            var str_ImgURL=""
            str_ImgURL=Prof_Data.avatar_url ?? ""
            cell.imgIcon.frame=CGRect(x: 15, y: cell.contentView.frame.height/2-25, width: 50, height: 50)
            cell.imgIcon.layer.cornerRadius=cell.imgIcon.frame.width/2
            cell.imgIcon.contentMode = .scaleAspectFit
            cell.imgIcon.clipsToBounds=true
            
        
            cell.imgIcon.sd_setImage(with: URL(string: str_ImgURL), placeholderImage: UIImage(named: "icon_Profile"))
       
        
            cell.lblUserName.text=Prof_Data.login
            cell.btnGit_Url.tag=indexPath.row
            cell.btnFollowers.tag=indexPath.row
            cell.btnFollowing.tag=indexPath.row
        
            cell.btnGit_Url.addTarget(self, action: #selector(btnViewOnSitePressed(sender:)), for: .touchUpInside)
            cell.btnFollowing.addTarget(self, action: #selector(btnViewFollowingPressed(sender:)), for: .touchUpInside)
            cell.btnFollowers.addTarget(self, action: #selector(btnViewFollowersPressed(sender:)), for: .touchUpInside)
        
            //cell.lblFollowers.text="Followers:\(Prof_Data.followers ?? 0)"
           // cell.lblFollowing.text="Following: \(Prof_Data.following ?? 0)"
            print(Prof_Data)
        
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationController?.navigationBar.topItem?.title = ""
         let prof_Detail:Profile_DetailsScreen=storyboard?.instantiateViewController(withIdentifier: "prof_detail") as! Profile_DetailsScreen
        let Prof_Data=arrProfil_List[indexPath.row]
       
        appDelegate.strUserName=Prof_Data.login ?? ""
         self.navigationController?.pushViewController(prof_Detail, animated: true)
    }
    
    //MAR: UIButton pressed delegate declarations
    @objc func btnViewFollowingPressed(sender:UIButton)
    {
        var row=Int()
        row=sender.tag
        
        let Prof_Data=arrProfil_List[row]
        appDelegate.strUserName=Prof_Data.login ?? ""
        navigationController?.navigationBar.topItem?.title = ""
        let ffScreen:FollowesFollowingScreen=storyboard?.instantiateViewController(withIdentifier: "ffScreen") as! FollowesFollowingScreen
        appDelegate.strFF_Title="Following"
        appDelegate.strFF = "following"
        
        self.navigationController?.pushViewController(ffScreen, animated: true)
    }
    
    @objc func btnViewFollowersPressed(sender:UIButton)
    {
        var row=Int()
        row=sender.tag
        
        let Prof_Data=arrProfil_List[row]
        appDelegate.strUserName=Prof_Data.login ?? ""
        navigationController?.navigationBar.topItem?.title = ""
        let ffScreen:FollowesFollowingScreen=storyboard?.instantiateViewController(withIdentifier: "ffScreen") as! FollowesFollowingScreen
        appDelegate.strFF_Title="Followers"
        appDelegate.strFF="followers"
        self.navigationController?.pushViewController(ffScreen, animated: true)
    }
    
    @objc func btnViewOnSitePressed(sender:UIButton)
    {
        var row=Int()
        row=sender.tag
        
          let Prof_Data=arrProfil_List[row]
        
        if let url = URL(string: Prof_Data.html_url!) {
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
    func loadSearchUserAPI() {
        
        showSpinner("Loading...")
        
        Services.sharedInstance.getAllUsers_List{(prof_Info,error) in
            OperationQueue.main.addOperation({
                if error==nil
                {
                    if prof_Info?.count==0
                    {
                        showAlert("", message: "Record not found", buttonTitle: "Ok")
                    }
                    
                        self.arrProfil_List=prof_Info ?? []
                        self.tblProfiles_List.reloadData()
                }
                else
                {
                    showAlert("", message: "Record not found", buttonTitle: "Ok")
                    
                }
                
                appDelegate.strSearch_text=""
                
                self.txtSearch.text=""
                
                dismissSpinner()
            })
            
        }
    }
}
