import SwiftUI

struct GeneralInteractor: Interactor {
    var todo: TodoInteractor
    
    init(state: AppStateContainer, repo: Repository) {
        self.todo = GeneralTodoInteractor(state: state, repo: repo)
    }
}
