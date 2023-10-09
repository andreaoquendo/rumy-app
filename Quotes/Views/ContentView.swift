//
//  ContentView.swift
//  Quotes
//
//  Created by Andrea Oquendo on 06/10/23.
//

import SwiftUI
import SwiftData
import UIKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(QuestionManager.self) private var questionManager
    
    @State private var animateGradient = true
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "paleDarkPurple")
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.1)
    }

    var body: some View {
        NavigationView{
            VStack(spacing: 32){
                VStack(spacing: 10){
                    Text("it's journaling hour")
                        .font(.customTitle)
                        .foregroundColor(.darkPurple)
                    Text("choose a theme to start writing")
                        .font(.customBody)
                        .foregroundColor(.darkPurple)
                }
                
                
                TabView{
                    
                    ForEach(questionManager.questionTypes, id: \.self) { type in
                        NavigationLink(destination: PromptView(questionType: type.type)){
                            ThemeItem(themeItem: type)
                        }
                        
                    }
                    
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .never))
                .frame(height: 450, alignment: .center)
                
                
                
                NavigationLink{
                    FavoriteView()
                } label: {
                    HStack(spacing: 10){
                        Image(systemName: "heart")
                        Text("Favorites")
                            .font(.customBodyBold)
                    }
                    .foregroundColor(.darkPurple)
                }
                
                
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight:.infinity)
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
//            .background(
//                LinearGradient(
//                    colors: [.backgroundDark, .backgroundLight],
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//                )
//                .edgesIgnoringSafeArea(.all)
//                .hueRotation(.degrees(animateGradient ? 45 : 0))
//                .onAppear(){
//                    withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
//                        animateGradient.toggle()
//                    }
//                }
//            )
        }
        
        
    }
    
    func ThemeItem(themeItem: QuestionType) -> some View {
        ZStack{
//            
//            RoundedRectangle(cornerRadius: 112)
//                
//                
//                .frame(width: 260, height: 360)
//                .padding(.horizontal, 16)
//                .padding(.vertical, 42)
//                .foregroundColor(.white.opacity(0.2))
//                .shadow(color: .pink.opacity(0.2), radius: 20, x: 0, y: 0)
            
            
            VStack(alignment: .center, spacing: 32) {
                Image(systemName: "heart")
                    .font(.system(size: 80))
                    .bold()
                
                VStack(spacing:10){
                    Text(themeItem.name)
                        .font(.customTitle2)
                    Text(themeItem.description)
                        .font(.themeDescription)
                        .multilineTextAlignment(.center)
                    
                }
                .padding(.horizontal, 24)
        
            }
            .frame(width: 260, height: 360, alignment: .center)
            .foregroundColor(Color.darkPurple)
//            .padding(.horizontal, 16)
//            .padding(.vertical, 42)
            .background(.white.opacity(0.1))
            .cornerRadius(112)
            
            .overlay(
                RoundedRectangle(cornerRadius: 112)
                    .inset(by: 1)
                    .stroke(Color.darkPurple, lineWidth: 2 )
            )
        }
    }

}
//
#Preview {
    ContentView()
        .modelContainer(for: FavoriteQuestion.self, inMemory: true)
        .environment(QuestionManager())
}

//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
