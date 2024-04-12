import SwiftUI

fileprivate enum TodoEditor {
    case new
    case edit(Todo)
}

struct TodoListView: View {
    @Environment(\.injected) private var container
    @State private var todoEditorContent: String = ""
    @State private var todoEditor: TodoEditor?
    
    @State private var todos: [Todo] = []
    
    var showTodoEditor: Binding<Bool> {
        Binding {
            return todoEditor != nil
        } set: { val in
            if !val {
                todoEditor = nil
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Todo List")
                    .font(.system(.largeTitle, design: .rounded, weight: .medium))
                Spacer()
            }
            
            List {
                ForEach(todos) { todo in
                    todoRowView(todo)
                }
                .listRowBackground(EmptyView())
            }
            .listStyle(.plain)
            
            Button {
                todoEditor = .new
            } label: {
                Image(systemName: "plus")
                .font(.system(.largeTitle, design: .rounded))
                .padding()
            }
        }
        .padding([.horizontal, .top])
        .sheet(isPresented: showTodoEditor) {
            todoEditorContent = ""
        } content: {
            todoEditorSheetView()
        }
        .animation(.smooth, value: todos)
        .onReceive(container.state.todoList) { todos = $0 }
        .onAppear {
            container.inter.todo.fetchTodo()
        }
    }
    
    @MainActor
    @ViewBuilder
    private func todoRowView(_ todo: Todo) -> some View {
        HStack {
            Text("\(todo.id)")
            Text(todo.content)
        }
        .swipeActions(edge: .trailing) { trailingActionView(todo) }
    }
    
    @MainActor
    @ViewBuilder
    private func trailingActionView(_ todo: Todo) -> some View {
        Button(role: .destructive) {
            container.inter.todo.removeTodo(todo.id)
        } label: {
            Image(systemName: "trash")
        }
        
        Button {
            todoEditorContent = todo.content
            todoEditor = .edit(todo)
        } label: {
            Image(systemName: "square.and.pencil")
        }
    }
    
    @MainActor
    @ViewBuilder
    private func todoEditorSheetView() -> some View {
        switch todoEditor {
        case .new, nil:
            todoEditorView(Todo(), isEdit: false)
        case .edit(let todo):
            todoEditorView(todo, isEdit: true)
        }
    }
    
    @MainActor
    @ViewBuilder
    private func todoEditorView(_ todo: Todo, isEdit: Bool) -> some View {
        VStack(spacing: 20) {
            Text(isEdit ? "Edit Todo" : "Add Todo")
                .font(.system(.title3, design: .rounded, weight: .medium))
            
            TextField("make breakfast", text: $todoEditorContent)
                .textFieldStyle(.plain)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            HStack {
                Button("cancel", role: .cancel) {
                    todoEditor = nil
                }
                .foregroundStyle(.secondary)
                
                Spacer()
                
                Button("confirm") {
                    defer { todoEditor = nil }
                    
                    if !isEdit {
                        container.inter.todo.addTodo(Todo(content: todoEditorContent))
                        return
                    }
                    
                    guard todo.content != todoEditorContent else { return }
                    
                    container.inter.todo.updateTodo(todo.id, UpdateTodoOption(
                        content: todoEditorContent
                    ))
                }
            }
            .fontWeight(.medium)
            .padding(.horizontal, 5)
            
            Spacer()
        }
        .padding(30)
    }
}

#if DEBUG
struct TodoListPreview: View {
    @State var todos = Todo.mocks
    var body: some View {
        TodoListView()
            .inject(.preview)
    }
}

#Preview {
    TodoListPreview()
        .preferredColorScheme(.light)
}
#endif
