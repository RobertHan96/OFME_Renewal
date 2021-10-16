//
//  NetworkUtils.swift
//  OfMe
//
//  Created by HanaHan on 2021/10/17.
//

import Foundation
import Network
import UIKit

struct NetworkUtils {
    let infromAlert = CustomInformAlert(titleText: Strings.networkConectionFaildTitleAlert, subText: Strings.networkConectionFaildSubAlert)

    func checkNetworkConnectivity(currentView: UIView) -> Bool {
        var result = true
        
        let monitor = NWPathMonitor()
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("LOG - 네트워크 연결 성공")
            } else {
                showNetworkErrorPopup(currentView: currentView)
                monitor.cancel()
                print("LOG - 네트워크 연결 실패 : 기기의 인터넷 접속 상태를 확인하세요.")
                result = false
            }
        }
        return result
    }
    
    func showNetworkErrorPopup(currentView: UIView) {
        DispatchQueue.main.async {
            self.infromAlert.setConstraint(view: currentView)
        }
    }

}
