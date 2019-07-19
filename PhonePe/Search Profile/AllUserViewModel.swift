//
//  ProfileViewModel.swift
//  PhonePe
//
//  Created by IBS on 7/10/19.
//  Copyright © 2019 IBS. All rights reserved.
//

import UIKit

class AllUserViewModel: NSObject {
    
    let items : [AllUserModel]?
    let total_count : Int?
    let incomplete_results : Bool?
    
    
     init(users:AllUserModelResult) {
        
        self.items=users.items
        self.total_count=users.total_count
        self.incomplete_results=users.incomplete_results
   }
    

}
