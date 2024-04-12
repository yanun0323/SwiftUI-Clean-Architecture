import SwiftUI
import Sworm

struct GeneralRepository: Repository {
    var todo: TodoRepository
    let basic: BasicRepository
    
    init(inMemory: Bool) {
        let db = Sworm.setup(mock: inMemory)
        let basic = BasicRepositoryObject()
        
        self.todo = GeneralTodoRepository(db: db, basic: basic)
        self.basic = basic
        
        db.migrate(Todo.self)
    }
}

extension GeneralRepository {
    func tx(action: @escaping () throws -> Void, success: @escaping () -> Void, failed: @escaping (any Error) -> Void) {
        basic.tx(action: action, success: success, failed: failed)
    }
}

struct BasicRepositoryObject: BasicDao, BasicRepository {}
