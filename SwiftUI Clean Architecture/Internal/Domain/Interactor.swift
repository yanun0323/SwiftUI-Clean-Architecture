import SwiftUI

protocol Interactor {
    var todo: TodoInteractor { get }
}

protocol TodoInteractor {
    func fetchTodo()
    func addTodo(_ todo: Todo)
    func updateTodo(_ todoID: Int64, _ opt: UpdateTodoOption)
    func removeTodo(_ todoID: Int64)
}

struct UpdateTodoOption {
    let content: String?
    let complete: Bool?
    
    init(content: String? = nil, complete: Bool? = nil) {
        self.content = content
        self.complete = complete
    }
}
