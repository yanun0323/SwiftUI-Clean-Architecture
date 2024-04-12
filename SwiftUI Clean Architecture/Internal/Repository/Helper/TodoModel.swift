import SwiftUI
import Sworm
import SQLite

extension Todo: Model {
    static var tableName: String = "todo"
    
    static let id = Expression<Int64>("id")
    static let content = Expression<String>("content")
    static let complete = Expression<Bool>("complete")
    static let createdAt = Expression<Int64>("created_at")
    static let updatedAt = Expression<Int64>("updated_at")
    
    static func migrate(_ db: DB) throws {
           try db.run(table.create(ifNotExists: true) { t in
               t.column(id, primaryKey: .autoincrement)
               t.column(content)
               t.column(complete)
               t.column(createdAt)
               t.column(updatedAt)
           })
       }
    
    static func parse(_ row: Row) throws -> Todo {
        return Todo(
            id: try row.get(id),
            content: try row.get(content),
            complete: try row.get(complete),
            createdAt: try row.get(createdAt),
            updatedAt: try row.get(updatedAt)
        )
    }
    
    func setter() -> [Setter] {
        return [
            Todo.content <- content,
            Todo.complete <- complete,
            Todo.createdAt <- createdAt,
            Todo.updatedAt <- updatedAt
        ]
    }
}
