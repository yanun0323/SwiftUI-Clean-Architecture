import SwiftUI

struct MockInteractor: Interactor {
    var todo: TodoInteractor
    
    init(state: AppStateContainer, repo: Repository) {
        self.todo = GeneralTodoInteractor(state: state, repo: repo)
    }
}
