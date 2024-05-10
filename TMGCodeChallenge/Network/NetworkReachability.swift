//
//  NetworkReachability.swift
//  TMGCodeChallenge
//
//  Created by Othmar Gispert Sr. on 5/10/24.
//

import Foundation
import Network

final class Network: ObservableObject {
    @Published private(set) var connected: Bool = false

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")

    func checkConnection() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self.connected = true
                } else {
                    self.connected = false
                }
            }
        }
        monitor.start(queue: queue)
    }
}
