import SwiftUI
import Sworm
import SQLite

struct GeneralTodoRepository {
    let db: DB
    let basic: BasicRepository
}

extension GeneralTodoRepository: TodoRepository {
    func listTodo() throws -> [Todo] {
        return try basic.query(Todo.self, query: { $0.order(Todo.id.asc) })
    }
    
    func getTodo(_ todoID: Int64) throws -> Todo {
        let todos: [Todo] = try basic.query(Todo.self, query: { $0.where(Todo.id == todoID).order(Todo.id.asc) })
        
        guard let todo = todos.first else {
            throw ErrRepository.recordNotFound
        }
        
        return todo
    }
    
    func createTodo(_ todo: Todo) throws -> Int64 {
        return try basic.insert(todo)
    }
    
    func updateTodo(_ todoID: Int64, _ opt: UpdateTodoOption) throws {
        var setter = [Setter]([Todo.updatedAt <- Int64(Date.now.timeIntervalSince1970)])
        if let content = opt.content {
            setter.append(Todo.content <- content)
        }
        
        if let complete = opt.complete {
            setter.append(Todo.complete <- complete)
        }
        
        let count: Int = try basic.update(Todo(), set: setter, query: { $0.where(Todo.id == todoID) })
       
        
        if count == 0 {
            throw ErrRepository.recordNotFound
        }
    }
    
    func removeTodo(_ todoID: Int64) throws {
        let _: Int = try basic.delete(Todo.self, query: { $0.where(Todo.id == todoID) })
    }
}
