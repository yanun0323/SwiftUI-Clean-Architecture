//
//  SwiftUI_Clean_ArchitectureApp.swift
//  SwiftUI Clean Architecture
//
//  Created by Yanun on 2024/4/12.
//

import SwiftUI

@main
struct SwiftUI_Clean_ArchitectureApp: App {
    let container = DIContainer(param: .general(inMemory: false))
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .inject(container)
        }
    }
}
