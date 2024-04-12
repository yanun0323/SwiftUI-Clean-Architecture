//
//  ContentView.swift
//  SwiftUI Clean Architecture
//
//  Created by Yanun on 2024/4/12.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.injected) private var container
    @State private var error: Error?
    
    var body: some View {
        TodoListView()
            .onReceive(container.state.error) {
                error = $0
            }
            .alert("Error", isPresented: Binding{
                return error != nil
            } set: { val in
                if !val { error = nil }
            }, actions: {
                
            }, message: {
                if error != nil {
                    Text("\(error!)")
                }
            })
    }
}

#if DEBUG
#Preview {
    ContentView()
        .inject(.inMemory)
}
#endif
