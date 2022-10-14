//
//  Recorder+Router.swift
//  Basirah
//
//  Created by Nadia Seleem on 4/20/21.
//  Copyright © 2021 Nadia seleem. All rights reserved.
//

import Foundation
import AVKit
import UIKit
extension RecorderVC
{
    enum RecorderRouterDestinations
    {
        case player
    }
    
    func route(to destination: RecorderRouterDestinations)
    {
        
        switch destination
        {
        case .player:
            
                let playerController = AVPlayerViewController()
                let audioPlayer =  AVPlayer(url: recorder.url)
                playerController.player = audioPlayer
                self.present(playerController, animated: true, completion: nil)
            
        }
    }
    
    
}
