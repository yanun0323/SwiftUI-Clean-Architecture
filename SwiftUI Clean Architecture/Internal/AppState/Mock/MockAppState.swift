import SwiftUI
import Combine

struct MockAppState: AppStateDelegate {
    var todoListStored = Store<[Todo]>([])
    var errorChannel = Channel<Error>()
}


extension MockAppState: AppState {
    var todoList: AnyProducer<[Todo]> {
        return todoListStored.eraseToAnyPublisher()
    }
    
    var error: AnyProducer<Error> {
        return errorChannel.eraseToAnyPublisher()
    }
}
