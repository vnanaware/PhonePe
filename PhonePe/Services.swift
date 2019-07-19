//
//  Services.swift
//  DocMS
//
//  Created by IBS on 6/13/19.
//  Copyright © 2019 IBS. All rights reserved.
//

import UIKit

struct Message: Decodable {
   
    let message: String?
    
}

class Services: NSObject {

    static let sharedInstance = Services()
    

    //MARK: Get All Users list API
    func getAllUsers_List(completion:@escaping([AllUserModel]?,Error?) -> ()) {
        
        let urlString = vAPIBaseURL+"search/users?q=\(appDelegate.strSearch_text)&page=1"
        
        guard let url = URL(string: urlString) else {   return  }
        
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let parameters: [String: Any] = [ : ]
        
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            
             var arrProfileData = [AllUserModel]()
            
            if let err = error{
                completion(nil,err)
                dismissSpinner()
            }else{
                guard let data = data else { return }
                do{
                   
                        let results = try JSONDecoder().decode(AllUserModelResult.self, from: data)
                       
                        for profile in results.items!{
                                
                                arrProfileData.append(AllUserModel(avatar_url: profile.avatar_url!, events_url: profile.events_url!, followers_url: profile.followers_url!, following_url: profile.following_url!, gists_url: profile.gists_url!, gravatar_id: profile.gravatar_id!, html_url: profile.html_url!, id: profile.id!, login: profile.login!, node_id: profile.node_id!, organizations_url: profile.organizations_url!, received_events_url: profile.received_events_url!, repos_url: profile.repos_url!, starred_url: profile.starred_url!, subscriptions_url: profile.subscriptions_url!, type: profile.type!, url: profile.url!))
                            
                        }
                        completion(arrProfileData, error)
                   
                }catch let jsonErr{
                    
                    dismissSpinner()
                    completion(arrProfileData, jsonErr.localizedDescription as? Error)
                    
                }
            }
            }.resume()
    }

   
    //MARK: Get selected user profile info
    func getSelectedUser_Info(completion:@escaping(ProfileInfo_Model?,Error?) -> ()) {
        
        
        //let urlString = vAPIBaseURL+"searchBroadcastMessages"
        let urlString = vAPIBaseURL+"users/\(appDelegate.strUserName)"
        
        guard let url = URL(string: urlString) else {   return  }
        
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let parameters: [String: Any] = [ : ]
        
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            
            var arrProfile_Info:ProfileInfo_Model?
            
            if let err = error{
                completion(nil,err)
                dismissSpinner()
            }else{
                guard let data = data else { return }
                do{
                    
                    arrProfile_Info = try JSONDecoder().decode(ProfileInfo_Model.self, from: data)
                    
                 
                    completion(arrProfile_Info, error)
                    
                }catch let jsonErr{
                    
                    dismissSpinner()
                    completion(arrProfile_Info, jsonErr.localizedDescription as? Error)
                    
                }
            }
            }.resume()
    }
}


extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
