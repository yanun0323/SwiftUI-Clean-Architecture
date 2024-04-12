import SwiftUI

struct Todo {
    var id: Int64
    var content: String
    var complete: Bool
    var createdAt: Int64
    let updatedAt: Int64
    
    init(id: Int64 = 0, content: String = "", complete: Bool = false, createdAt: Int64? = nil, updatedAt: Int64? = nil) {
        let now = Int64(Date.now.timeIntervalSince1970)
        self.id = id
        self.content = content
        self.complete = complete
        self.createdAt = createdAt ?? now
        self.updatedAt = updatedAt ?? now
    }
}

extension Todo: Identifiable {}
extension Todo: Hashable {}
