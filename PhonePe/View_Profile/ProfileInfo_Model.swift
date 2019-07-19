//
//  ProfileInfoModel.swift
//  PhonePe
//
//  Created by IBS on 7/17/19.
//  Copyright © 2019 IBS. All rights reserved.
//

import Foundation

class ProfileInfo_Model: Decodable {
 
    let avatar_url : String?
    let bio : String?
    let blog : String?
    let company : String?
    let created_at : String?
    let email : String?
    let events_url:String?
    let followers:Int?
    let followers_url:String?
    let following:Int?
    let following_url:String?
    let gists_url:String?
    let gravatar_id:String?
    let hireable:String?
    let html_url:String?
    let id:Int?
    let location:String?
    let login:String?
    let name:String?
    let node_id:String?
    let organizations_url:String?
    let public_gists:Int?
    let public_repos:Int?
    let received_events_url:String?
    let repos_url:String?
    let letsite_admin:String?
    let starred_url:String?
    let subscriptions_url:String?
    let type:String?
    let updated_at:String?
    let url:String?
 
 
        init(avatar_url:String, bio:String, blog:String, company:String, created_at:String, email:String, events_url:String, followers:Int, followers_url:String, following:Int, following_url:String, gists_url:String, gravatar_id:String, hireable:String, html_url:String, id:Int, location:String, login:String, name:String, node_id:String, organizations_url:String, public_gists:Int, public_repos:Int, received_events_url:String, repos_url:String, letsite_admin:String, starred_url:String, subscriptions_url:String, type:String, updated_at:String, url:String) {
 
 
                self.avatar_url=avatar_url
                self.bio=bio
                self.blog=blog
                self.company=company
                self.created_at=created_at
                self.email=email
                self.events_url=events_url
                self.followers=followers
                self.followers_url=followers_url
                self.following=following
                self.following_url=following_url
                self.gists_url=gists_url
                self.gravatar_id=gravatar_id
                self.hireable=hireable
                self.html_url=html_url
                self.id=id
                self.location=location
                self.login=login
                self.name=name
                self.node_id=node_id
                self.organizations_url=organizations_url
                self.public_gists=public_gists
                self.public_repos=public_repos
                self.received_events_url=received_events_url
                self.repos_url=repos_url
                self.letsite_admin=letsite_admin
                self.starred_url=starred_url
                self.subscriptions_url=subscriptions_url
                self.type=type
                self.updated_at=updated_at
                self.url=url
            }
    }


