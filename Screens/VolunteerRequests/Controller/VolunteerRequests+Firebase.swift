//
//  VolunteerRequests+Firebase.swift
//  Basirah
//
//  Created by Nadia Seleem on 4/20/21.
//  Copyright © 2021 Nadia seleem. All rights reserved.
//

import Foundation
import Firebase
import ObjectMapper

extension VolunteerRequests
{
 
    func getAllRequests(_ successHandler:@escaping (_ requests: [Request])->(),_ failHandler: @escaping (_ msg: String)->())
  {
        ref = Database.database().reference()
        guard let _ = Auth.auth().currentUser?.uid else
        {
            
            failHandler("حدث خطأ في تحميل الطلبات")
            return
    
        }
    
    
    self.ref.child(RequestKeys.mainKey).observeSingleEvent(of: .value)
    {
        
        (snapshot, str) in
    
        guard let requestDictArray = snapshot.value as? [String:[String:[String:AnyObject]]] else
        {
            failHandler("لا توجد طلبات حتي الآن")
            return
        }
        
        var requests:[Request] = []
       
            for (userID,userRequestsArray) in requestDictArray
            {
                for (requestTimestamp,requestDict) in userRequestsArray
                {
                    let date = Date(timeIntervalSince1970: Double(requestTimestamp) ?? 0.0)
                    
                    guard let request = Request(JSON: requestDict) else
                    {
                        failHandler("حدث خطأ في تحميل الطلبات")
                        return
                    }
                    request.bookDate = date.description
                    request.requestOwner = userID
                    request.requestTimestamp = requestTimestamp
                    if request.response == nil
                    {
                     requests.append(request)
                    }
                    
                }
            }
 
        
        successHandler(requests)
    }
    
    
    
    
    }
    
}
