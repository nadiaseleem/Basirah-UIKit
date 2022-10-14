//
//  VolunteerRequests+Router.swift
//  Basirah
//
//  Created by Nadia Seleem on 4/20/21.
//  Copyright © 2021 Nadia seleem. All rights reserved.
//

import Foundation
import UIKit
import AVKit
extension VolunteerRequests
{
    enum VolunteerRequestsRouterDestinations
    {
        case recorder(request: Request)
    }
    
    func route(to destination: VolunteerRequestsRouterDestinations)
    {
        
        switch destination
        {
            case .recorder(let request):
                let recorder = RecorderVC(nibName: "RecorderVC", bundle: nil)
                recorder.request = request
                self.present(recorder, animated: true, completion: nil)
            
        }
    }
    
    
}
