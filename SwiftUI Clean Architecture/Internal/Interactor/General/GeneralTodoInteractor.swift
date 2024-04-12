import SwiftUI

struct GeneralTodoInteractor {
    private let state: AppStateContainer
    private let repo: Repository
    
    init(state: AppStateContainer, repo: Repository) {
        self.state = state
        self.repo = repo
    }
}

extension GeneralTodoInteractor: TodoInteractor {
    func fetchTodo() {
        var todoList = [Todo]()
        repo.tx {
            todoList = try repo.todo.listTodo()
        } success: {
            state.todoListStored.send(todoList)
        } failed: {
            state.errorChannel.send($0)
        }
    }
    
    func addTodo(_ todo: Todo) {
        var todoList = [Todo]()
        repo.tx {
            let _ = try repo.todo.createTodo(todo)
            todoList = try repo.todo.listTodo()
        } success: {
            state.todoListStored.send(todoList)
        } failed: {
            state.errorChannel.send($0)
        }
    }
    
    func updateTodo(_ todoID: Int64, _ opt: UpdateTodoOption) {
        var todoList = [Todo]()
        repo.tx {
            let _ = try repo.todo.updateTodo(todoID, opt)
            todoList = try repo.todo.listTodo()
        } success: {
            state.todoListStored.send(todoList)
        } failed: {
            state.errorChannel.send($0)
        }
    }
    
    func removeTodo(_ todoID: Int64) {
        var todoList = [Todo]()
        repo.tx {
            let _ = try repo.todo.removeTodo(todoID)
            todoList = try repo.todo.listTodo()
        } success: {
            state.todoListStored.send(todoList)
        } failed: {
            state.errorChannel.send($0)
        }
    }
}
