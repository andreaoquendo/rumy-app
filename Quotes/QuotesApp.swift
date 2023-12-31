//
//  QuotesApp.swift
//  Quotes
//
//  Created by Andrea Oquendo on 06/10/23.
//

import SwiftUI
import SwiftData

@main
struct QuotesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            FavoriteQuestion.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @State private var questionManager = QuestionManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(questionManager)
        .modelContainer(sharedModelContainer)
        
    }
}
