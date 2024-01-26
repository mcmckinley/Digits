//
//  QuizSummaryView.swift
//  Digits
//
//  Created by Michael McKinley on 1/26/24.
//

import SwiftUI

struct QuizSummaryView: View {
    let responses: [Response]
    
    var body: some View {
        List {
            Text("hi")
        }
        .navigationTitle("hi")
        /*
        List(responses) { response in
            Text(response.userResponse)
            
        }
         */
    }
}

#Preview {
    QuizSummaryView(responses: Response.sampleData)
}

