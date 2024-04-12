import SwiftUI
import Combine

struct GeneralAppState: AppStateContainer {
    var todoListStored = Store<[Todo]>([])
    var errorChannel = Channel<Error>()
}


extension GeneralAppState: AppState {
    var todoList: AnyProducer<[Todo]> {
        return todoListStored.eraseToAnyPublisher()
    }
    
    var error: AnyProducer<Error> {
        return errorChannel.eraseToAnyPublisher()
    }
}
