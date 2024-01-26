import SwiftUI

struct QuizView: View {
    let contacts: [Contact]
    
    @State var quizIsFinished: Bool = false;
    
    var body: some View {
        if quizIsFinished {
            QuizSummaryView()
        } else {
            QuizActiveView(contacts: contacts, quizIsFinished: $quizIsFinished)
        }
    }
}

#Preview {
    QuizView(contacts: Contact.sampleData)
}
