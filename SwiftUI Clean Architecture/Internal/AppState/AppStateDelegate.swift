import SwiftUI

protocol AppStateDelegate {
    var todoListStored: Store<[Todo]> { get }
    var errorChannel: Channel<Error> { get }
}
