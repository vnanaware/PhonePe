//
//  Profile_ListModel.swift
//  PhonePe
//
//  Created by IBS on 7/10/19.
//  Copyright © 2019 IBS. All rights reserved.
//

import UIKit
    
    class AllUserModelResult: Decodable {
        
        let items : [AllUserModel]?
        let total_count : Int?
        let incomplete_results : Bool?
    }
    
    
    class AllUserModel: Decodable {
        
        let avatar_url : String?
        let events_url : String?
        let followers_url : String?
        let following_url : String?
        let gists_url : String?
        let gravatar_id : String?
        let html_url : String?
        let id : Int?
        let login : String?
        let node_id : String?
        let organizations_url : String?
        let received_events_url : String?
        let repos_url : String?
        let starred_url : String?
        let subscriptions_url : String?
        let type : String?
        let url : String?
        
        init(avatar_url:String, events_url:String, followers_url:String, following_url:String, gists_url:String, gravatar_id:String, html_url:String, id:Int, login:String, node_id:String, organizations_url:String, received_events_url:String, repos_url:String, starred_url:String, subscriptions_url:String, type:String, url:String) {
            
            self.avatar_url=avatar_url
            self.events_url=events_url
            self.followers_url=followers_url
            self.following_url=following_url
            self.gists_url=gists_url
            self.gravatar_id=gravatar_id
            self.html_url=html_url
            self.id=id
            self.login=login
            self.node_id=node_id
            self.organizations_url=organizations_url
            self.received_events_url=received_events_url
            self.repos_url=repos_url
            self.starred_url=starred_url
            self.subscriptions_url=subscriptions_url
            self.type=type
            self.url=url
        }
        /*
        let avatar_url:String?
        let events_url:String?
        let followers_url:String?
        let following_url:String?
        let gists_url:String?
        let gravatar_id:String?
        let html_url:String?
        let id:Int?
        let login:String?
        let node_id:String?
        let organizations_url:String?
        let received_events_url:String?
        let repos_url:String?
       
        let site_admin:Bool?
        let starred_url:String?
        let subscriptions_url:String?
        let type:String?
        let url:String?
        
        init(avatar_url:String, events_url:String, followers_url:String, following_url:String, gists_url:String, gravatar_id:String, html_url:String, id:Int, login:String, node_id:String, organizations_url:String, received_events_url:String, repos_url:String , site_admin:Bool, starred_url:String, subscriptions_url:String, type:String, url:String) {
            
            self.avatar_url=avatar_url
            self.events_url=events_url
            self.followers_url=followers_url
            self.following_url=following_url
            self.gists_url=gists_url
            self.gravatar_id=gravatar_id
            self.html_url=html_url
            self.id=id
            self.login=login
            self.node_id=node_id
            self.organizations_url=organizations_url
            self.received_events_url=received_events_url
            self.repos_url=repos_url
            self.site_admin=site_admin
            self.starred_url=starred_url
            self.subscriptions_url=subscriptions_url
            self.type=type
            self.url=url
        }*/
    }
