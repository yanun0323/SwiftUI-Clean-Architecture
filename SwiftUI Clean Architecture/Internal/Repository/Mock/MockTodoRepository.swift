import SwiftUI
import Sworm
import SQLite

extension Todo {
    static let mocks: [Todo] = [
        Todo(id: 0, content: "Mock first todo"),
        Todo(id: 1, content: "Mock second todo"),
        Todo(id: 3, content: "Mock third todo", complete: true)
    ]
}

class MockTodoRepository {
    private var cache: [Todo] = Todo.mocks
}

extension MockTodoRepository: TodoRepository {
    func listTodo() throws -> [Todo] {
        return cache
    }
    
    func getTodo(_ todoID: Int64) throws -> Todo {
        guard let todo = cache.first(where: { $0.id == todoID }) else {
            throw ErrRepository.recordNotFound
        }
        
        return todo
    }
    
    func createTodo(_ todo: Todo) throws -> Int64 {
        var lastID = Int64(0)
        cache.forEach({
            if $0.id > lastID {
                lastID = $0.id
            }
        })
        
        let id = lastID + 1
        let t = Todo(id: id, content: todo.content, complete: todo.complete)
        cache.append(t)
        
        return id
    }
    
    func updateTodo(_ todoID: Int64, _ opt: UpdateTodoOption) throws {
        guard let idx = cache.firstIndex(where: { $0.id == todoID }) else {
            throw ErrRepository.recordNotFound
        }
        
        let removed = cache.remove(at: idx)
        let todo = Todo(
            id: removed.id,
            content: opt.content ?? removed.content,
            complete: opt.complete ?? removed.complete,
            createdAt: removed.createdAt,
            updatedAt: Int64(Date.now.timeIntervalSince1970)
        )
        cache.append(todo)
        cache.sort(by: { $0.id < $1.id })
    }
    
    func removeTodo(_ todoID: Int64) throws {
        guard let idx = cache.firstIndex(where: { $0.id == todoID }) else {
            return
        }
        
        let _ = cache.remove(at: idx)
    }
}
