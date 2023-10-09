//
//  PromptView.swift
//  Quotes
//
//  Created by Andrea Oquendo on 06/10/23.
//

import SwiftUI
import SwiftData

struct PromptView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelContext
    
    let questionType: questionType
    
    @State var currentQuestion: String = ""
    var questionsAlreadyMade: [String] = []
    
    @Query private var questions: [FavoriteQuestion]
    
    var body: some View {
        VStack(spacing: 24){
            
            VStack(spacing: 8){
                Text("it's journaling hour")
                    .font(.customTitle)
                    .foregroundColor(.darkPurple)
                
                Text("your writing prompt is")
                    .font(.customBody)
                    .foregroundColor(.darkPurple)
            }
            
            
            
            Text(currentQuestion)
                .frame(height:212)
                .font(.customPrompt)
                .multilineTextAlignment(.center)
                .padding(16)
                .onAppear{
                    currentQuestion = getQuestion()
                }
                .foregroundColor(.darkPurple)
                .frame(height: 320, alignment: .center)
                .frame(maxWidth: .infinity)
            
            VStack {
                Button{
                    currentQuestion = getQuestion()
                } label: {
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: "shuffle")
                        Text("New Prompt")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .foregroundColor(.white)
                    .background(Color.darkPurple.opacity(0.5))
                    .cornerRadius(14)
                }
                
                HStack(alignment: .center, spacing: 10) {
                    
                    Image(systemName: isFavorite() ? "heart.fill" : "heart")
                    Text("Add to favorites")
                }
                .foregroundColor(.darkPurple)
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .cornerRadius(14)
                .onTapGesture {
                    addItem()
                }
                
                
            }
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 24)
        .background(
            EllipticalGradient(
            stops: [
            Gradient.Stop(color: Color(red: 1, green: 0.84, blue: 0.86), location: 0.00),
            Gradient.Stop(color: Color(red: 1, green: 0.64, blue: 0.76).opacity(0.5), location: 0.45),
            Gradient.Stop(color: Color(red: 1, green: 0.9, blue: 0.91), location: 1.00),
            ],
            center: UnitPoint(x: 0.5, y: 0.5)
            )
        )
        .navigationBarTitle("", displayMode: .inline) // Hide the default title
                .navigationBarBackButtonHidden(true) // Hide the default back button
                .navigationBarItems(leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left") // Use a custom back button icon
                            .foregroundColor(.darkPurple) // Change the color of the back button icon
                            .imageScale(.large)
                    }
                )
        
//        .padding(.horizontal, 24)
//        .edgesIgnoringSafeArea(.all)
    }
    
    private func addItem() {
        if isFavorite() {
            QuestionManager().removeFromFavorites(question: currentQuestion, allQuestions: questions, modelContext: modelContext)
        } else {
            QuestionManager().addToFavorites(question: currentQuestion, modelContext: modelContext)
        }
        
    }
    
    private func isFavorite() -> Bool {
        return QuestionManager().insideFavorites(
            allQuestions: questions,
            question: currentQuestion)
    }
        
    
    private func getQuestion() -> String {
        let questions = QuestionManager().getQuestionFromType(type: questionType)
        
        return questions.randomElement()?.text ?? "There are no questions in this category"
    }
    
}

#Preview {
    PromptView(questionType: .list)
        .modelContainer(for: FavoriteQuestion.self, inMemory: true)
}
