import SwiftUI

enum ErrRepository: Error {
    case recordNotFound
}

protocol Repository {
    var todo: TodoRepository { get }
    
    func tx(action: @escaping () throws -> Void, success: @escaping () -> Void, failed: @escaping (Error) -> Void)
}

protocol TodoRepository {
    func listTodo() throws -> [Todo]
    func getTodo(_ todoID: Int64) throws -> Todo
    func createTodo(_ todo: Todo) throws -> Int64
    func updateTodo(_ todoID: Int64, _ opt: UpdateTodoOption) throws
    func removeTodo(_ todoID: Int64) throws
}
