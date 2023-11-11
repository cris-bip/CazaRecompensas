//
//  InternetMonitor.swift
//  CazaRecompensas
//
//  Created by OITD on 11/11/23.
//

import Foundation
import Network

class InternetMonitor{
    var internetStatus = false
    var internetType = ""
    
    static let shared = InternetMonitor()
    
    private init(){
        let monitor = NWPathMonitor()
        monitor.start(queue: DispatchQueue.global())
        monitor.pathUpdateHandler  = {path in
            self.internetStatus = (path.status == .satisfied)
            
            if path.usesInterfaceType(.wifi){
                self.internetType = "Wifi"
            }else if path.usesInterfaceType(.cellular){
                self.internetType = "Cellular"
            }else{
                self.internetType = "Unknown"
            }
        }
    }
    
}

