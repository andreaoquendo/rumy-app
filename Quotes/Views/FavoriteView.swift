//
//  FavoriteView.swift
//  Quotes
//
//  Created by Andrea Oquendo on 06/10/23.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var questions: [FavoriteQuestion]
    @Environment(\.presentationMode) var presentationMode
    
    
    
    var body: some View {
        VStack(spacing: 24){
            
            VStack(spacing: 8){
                Text("your favorite prompts")
                    .font(.customTitle)
                    .foregroundColor(.darkPurple)
                
                Text("let's write about it?")
                    .font(.customBody)
                    .foregroundColor(.darkPurple)
            }
            
            ScrollView{
                VStack{
                    ForEach(questions, id:\.self){ question in
                        QuestionItemView(question: question)
                            .onLongPressGesture{
                                print("hora de morfar")
                            }
                        
                    }
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
    
    func QuestionItemView(question: FavoriteQuestion) -> some View{
        HStack(alignment: .top, spacing: 10) {
            Text(question.question)
                .font(.customBody)
              .foregroundColor(Color(red: 0.49, green: 0.29, blue: 0.45))
              .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .cornerRadius(12)
        .overlay(
        RoundedRectangle(cornerRadius: 12)
        .inset(by: 0.5)
        .stroke(Color(red: 0.49, green: 0.29, blue: 0.45), lineWidth: 1)
        )
        
    }
//    var body: some View {
//        VStack {
//            List {
//                ForEach(questions) { question in
//                    Text(question.question)
//                }
//                
//            }
//        }
//    }
}

//#Preview {
//    FavoriteView()
//        .modelContainer(for: FavoriteQuestion.self, inMemory: true)
//}
