import SwiftUI

protocol AppStateContainer {
    var todoListStored: Store<[Todo]> { get }
    var errorChannel: Channel<Error> { get }
}
