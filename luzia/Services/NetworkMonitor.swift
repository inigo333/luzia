//
//  NetworkMonitor.swift
//  luzia
//
//  Created by Inigo Mato on 17/01/2025.
//

import Network
import SwiftUI

final class NetworkMonitor: ObservableObject {
    @Published var isConnected = true
    private var monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    init() {
        monitor = NWPathMonitor()
        startMonitoring()
    }
    
    deinit {
        stopMonitoring()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
