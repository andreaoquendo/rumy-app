//
//  QuestionModel.swift
//  Quotes
//
//  Created by Andrea Oquendo on 06/10/23.
//

import Foundation
import SwiftData

enum questionType {
    case list, monthly, weekly, selfcare, dreams, discovery
}

struct QuestionModel {
    let id = UUID()
    var text: String
    var tags: [questionType]
}

struct QuestionType: Hashable {
    let name: String
    let type: questionType
    let description: String
}
/*
 "What are your core values, and how do they influence your decisions and actions?"
 "Reflect on a moment in your life that profoundly changed you. How did it shape your identity?"
 "What are some of your strengths and weaknesses? How can you leverage your strengths and work on your weaknesses?"
 "Describe a person who has had a significant impact on your life. What have you learned from this relationship?"
 "What are your long-term goals and dreams? How can you take steps toward achieving them?"
 "Write a letter to your younger self, offering advice and words of encouragement."
 "What are your favorite books, movies, or experiences? How have they influenced your perspective on life?"
 "Explore a challenging situation you've faced recently. What did you learn about yourself from this experience?"
 "Describe the environment or surroundings that make you feel most at peace and inspired."
 "Write down three things you're proud of accomplishing in your life so far. What do these achievements reveal about your character?"
 */

@Observable class QuestionManager {
    var allQuestions: [QuestionModel] = [
        QuestionModel(text: "When do you feel most like yourself?", tags: [.selfcare]),
        QuestionModel(text: "What has been the hardest thing to forgive yourself for?", tags: [.selfcare]),
        QuestionModel(text: "is there someone you're secretly seeking approval from? what would having their approval change?", tags: [.selfcare]),
        QuestionModel(text: "What is something you don't regret?", tags: [.selfcare]),
        QuestionModel(text: "make a movie list", tags: [.list]),
        QuestionModel(text: "make a bucket list", tags: [.list]),
        QuestionModel(text: "make a movie list", tags: [.list]),
        
        QuestionModel(text: "What are your core values, and how do they influence your decisions and actions?", tags: [.discovery]),
        QuestionModel(text: "Reflect on a moment in your life that profoundly changed you. How did it shape your identity?", tags: [.discovery]),
        QuestionModel(text: "What are some of your strengths and weaknesses? How can you leverage your strengths and work on your weaknesses?", tags: [.discovery]),
        QuestionModel(text: "Describe a person who has had a significant impact on your life. What have you learned from this relationship?", tags: [.discovery]),
        QuestionModel(text: "What are your long-term goals and dreams? How can you take steps toward achieving them?", tags: [.discovery, .dreams]),
        QuestionModel(text: "Write a letter to your younger self, offering advice and words of encouragement.", tags: [.discovery]),
        QuestionModel(text:  "What are your favorite books, movies, or experiences? How have they influenced your perspective on life?"
, tags: [.discovery]),
        QuestionModel(text: "Explore a challenging situation you've faced recently. What did you learn about yourself from this experience?", tags: [.discovery]),
        QuestionModel(text: "Describe the environment or surroundings that make you feel most at peace and inspired.", tags: [.discovery]),
        QuestionModel(text: "Write down three things you're proud of accomplishing in your life so far. What do these achievements reveal about your character?", tags: [.discovery, .dreams]),
        
    
    ]
    var questionTypes =
    [
        QuestionType(name: "lists", type: .list, description: "Create lists to organize thoughts, goals, or memories."),
        QuestionType(name: "weekly", type: .weekly, description: "Take a moment to pause and reflect on your week."),
        QuestionType(name: "monthly", type: .monthly, description: "A monthly reflection to capture the essence of the past month."),
        QuestionType(name: "self-care", type: .selfcare, description: "Explore self-care practices, thoughts, and feelings."),
        QuestionType(name: "self-discovery", type: .discovery, description: "Explore your inner world, uncover your values, and chart a path towards personal growth."),
        QuestionType(name: "dreams and aspirations", type: .dreams, description: "Explore your dreams, ambitions, and future goals.")
    ]
    
    
    
    static func getQuestionTypes() -> [String]{
        let types = ["weekly", "bi-weekly", "monthly", "self-care", "lists"]
        return types
    }
    
    static func getRandomQuestion() -> String {
        return ""
    }
    
    func isFromType(question: QuestionModel, type: questionType) -> Bool {
        return question.tags.contains(type)
    }
    
    func getQuestionFromType(type: questionType) -> [QuestionModel] {
        var questionsSelected: [QuestionModel] = []
        
        for question in allQuestions {
            if isFromType(question: question, type: type){
                questionsSelected.append(question)
            }
        }
            
        return questionsSelected
    }
    
    func getAllQuestions() -> [String] {
        
        return [
            "When do you feel most like yourself?",
            "What is something you wish others knew about you?",
            "What has been the hardest thing to forgive yourself for?",
            "is there someone you're secretly seeking approval from? what would having their approval change?",
            "What do you look forward everyday?",
            "What don't you regret?"
        ]
        
    }
    
    func addToFavorites(question: String, modelContext: ModelContext) {
        let newQuestion = FavoriteQuestion(question: question)
        modelContext.insert(newQuestion)
    }
    
    func removeFromFavorites(question: String, allQuestions: [FavoriteQuestion], modelContext: ModelContext) {
        for q in allQuestions {
            if question == q.question {
                modelContext.delete(q)
            }
            
        }
    }
    
    func insideFavorites(allQuestions: [FavoriteQuestion], question: String) -> Bool {
        for q in allQuestions {
            if question == q.question {
                return true
            }
        }
        
        return false
    }
    
    
    
}
