//
//  HandleTheme.swift
//  Weatherly
//
//  Created by Aya Mostafa on 20/05/2024.
//

import Foundation
import Combine

enum Theme {
    case light
    case dark
}

class HandleThem: ObservableObject {
    @Published var isTime: Bool = true

       private var cancellables = Set<AnyCancellable>()

       init() {
           changeTheme()
           startTimer()
       }
    
    private func changeTheme() {
        let hour = Calendar.current.component(.hour, from: Date())
        isTime = (hour >= 6 && hour < 18)
    }
    
    private func startTimer () {
        Timer.publish(every: 60, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.changeTheme()
            }
            .store(in: &cancellables)
    }
    
}
