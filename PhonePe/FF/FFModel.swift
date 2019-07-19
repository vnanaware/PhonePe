//
//  FFModel.swift
//  PhonePe
//
//  Created by IBS on 7/18/19.
//  Copyright © 2019 IBS. All rights reserved.
//

import Foundation

class FFModel: Decodable {
    let avatar_url : String?
    let followers_url : String?
    let following_url : String?
    let html_url : String?
    let id : Int?
    let login : String?
    
    init(avatar_url:String, events_url:String, followers_url:String, following_url:String, html_url:String, id:Int, login:String) {
        
        self.avatar_url=avatar_url
        self.followers_url=followers_url
        self.following_url=following_url
        self.html_url=html_url
        self.id=id
        self.login=login
    }
}
    class FFModel_Result: Decodable {
        
        var result=[FFModel]()
        
        init(prof:[FFModel]) {
            self.result=prof
        }
    }
