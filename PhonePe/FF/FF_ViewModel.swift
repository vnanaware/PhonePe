//
//  FF_ViewModel.swift
//  PhonePe
//
//  Created by IBS on 7/18/19.
//  Copyright © 2019 IBS. All rights reserved.
//

import Foundation

class FF_ViewModel: Decodable {
    let avatar_url : String?
    let followers_url : String?
    let following_url : String?
    let html_url : String?
    let id : Int?
    let login : String?
    
     init(profiles:FFModel) {
        
        self.avatar_url=profiles.avatar_url
       
        self.followers_url=profiles.followers_url
        self.following_url=profiles.following_url
        self.html_url=profiles.html_url
        self.id=profiles.id
        self.login=profiles.login
       
    }
}
