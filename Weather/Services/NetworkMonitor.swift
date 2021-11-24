//
//  ConnectionManeger.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 24.11.2021.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    public private(set) var connetionType: ConnectionType = .unknown
    
    enum ConnectionType {
        case wifi, cellular, ethernet, unknown
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {[weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connetionType = .wifi
        }
        else if path.usesInterfaceType(.cellular) {
            connetionType = .cellular
        }
        else if path.usesInterfaceType(.wiredEthernet) {
            connetionType = .ethernet
        }
        else {
            connetionType = .unknown
        }
    }
    
}
