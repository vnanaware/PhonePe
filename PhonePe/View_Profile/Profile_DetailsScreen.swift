//
//  Profile_DetailsScreen.swift
//  PhonePe
//
//  Created by IBS on 7/10/19.
//  Copyright © 2019 IBS. All rights reserved.
//

import UIKit

class prof_InfoCell: UITableViewCell {
    
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lbl_Info:UILabel!
    
}

class Profile_DetailsScreen: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tblProfile:UITableView!
    @IBOutlet var btnShare:UIBarButtonItem!
    
    
    var arrProf_titles=["Profile_Image","Username","Full Name","Location","Followers","Following","Public repository","Public gits","Last update"]
    
    //var prof_Data:Profile_ListModel?
    lazy var arrProf_Info:NSMutableArray=[]
    var arrInfo_Result:ProfileInfo_Model?
    var strUserName=""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadInitialUI()
        
        if appDelegate.isConnected
        {
            loadProfileInfo_API()
        }
        else
        {
            showAlert("", message: vAlertMessageInvalidCredential, buttonTitle: "Ok")
        }
       
    }
    
    //MARK: Load Initial UI
    func loadInitialUI() {
    
        //UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000.0, vertical: 0.0), for: .default)
        
        self.title="Profile"
        tblProfile.tableFooterView=UIView()
        btnShare.isEnabled=false
    }
    
    
    
    //MARK: UITableView Delegate and Datasource declarations here
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrProf_Info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:prof_InfoCell = self.tblProfile.dequeueReusableCell(withIdentifier: "cell") as! prof_InfoCell
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        
        
        //check for indexpath is 0 or not to display profile icon
        if indexPath.row==0{
            
            let imgProfile=UIImageView()
            imgProfile.frame=CGRect(x: 10, y: 20, width: 110, height: 110)
            
            var str_ImgURL=""
            str_ImgURL=self.arrProf_Info.object(at: indexPath.row) as! String
            imgProfile.sd_setImage(with: URL(string: str_ImgURL), placeholderImage: UIImage(named: "icon_Profile"))
            imgProfile.layer.cornerRadius=imgProfile.frame.width/2
            imgProfile.contentMode = .scaleAspectFit
            imgProfile.clipsToBounds=true
            cell.contentView.addSubview(imgProfile)
      
        }
        else{

            cell.lblTitle.text=self.arrProf_titles[indexPath.row]
            
            var str_Info=""
            
            str_Info=self.arrProf_Info.object(at: indexPath.row) as! String
            print(str_Info)
            
            if str_Info == ""
            {
                str_Info="N/A"
            }
            cell.lbl_Info.text=str_Info
        
        }
      
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        //First index height is 150 and others are 75
        if indexPath.row == 0
        {
            return 150
        }
        return 75
    }
    
    
    //MARK: UIButton pressed share pressed
    @IBAction func shareInfo_Pressed(_ sender: Any) {
    
        //var strWeb_URL=""
        guard let strWeb_URL=self.arrInfo_Result?.html_url! else { return }
        
        if strWeb_URL != ""
        {
            let text = "Check Github profile"
            let myWebsite = NSURL(string:strWeb_URL)
            let shareAll = [text, myWebsite ?? ""] as [Any]
            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    
    
    //MARK: Load Profile Info API
    func loadProfileInfo_API() {
        
        showSpinner("Loading...")
        Services.sharedInstance.getSelectedUser_Info{(result,error) in
            OperationQueue.main.addOperation({
                
                self.arrProf_Info.removeAllObjects()
                
                if error==nil
                {
                    
                    self.arrInfo_Result=result
                    self.arrProf_Info.add(result?.avatar_url ?? "N/A")
                    self.arrProf_Info.add(result?.login ?? "N/A")
                    self.arrProf_Info.add(result?.name ?? "N/A")
                    self.arrProf_Info.add(result?.location ?? "N/A")
                    self.arrProf_Info.add("\(result?.followers ?? 0)")
                    self.arrProf_Info.add("\(result?.following ?? 0)")
                    self.arrProf_Info.add("\(result?.public_repos ?? 0)")
                    self.arrProf_Info.add("\(result?.public_gists ?? 0)")
                    self.arrProf_Info.add(result?.created_at ?? "N/A")
                    
                    self.btnShare.isEnabled=true
                }
                else
                {
                    showAlert("", message: error!.localizedDescription, buttonTitle: "Ok")
                    
                }
                
                self.tblProfile.reloadData()
                
                dismissSpinner()
            })
            
        }
    }
}
