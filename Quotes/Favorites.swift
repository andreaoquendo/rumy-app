import Foundation
import SwiftData

@Model
final class FavoriteQuestion {
    var question: String
    
    init(question: String) {
        self.question = question
    }
}
