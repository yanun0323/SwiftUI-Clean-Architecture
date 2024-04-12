import SwiftUI
import Sworm

struct MockRepository: Repository {
    var todo: TodoRepository
    
    init() {
        self.todo = MockTodoRepository()
    }
}

extension MockRepository {
    func tx(action: @escaping () throws -> Void, success: @escaping () -> Void, failed: @escaping (any Error) -> Void) {
        do {
            try action()
            success()
        } catch {
            failed(error)
        }
    }
}
