//
//  Question.swift
//  HP Trivia
//
//  Created by Admin on 2023-07-26.
//

import Foundation

struct Question: Codable{
    
    let id : Int
    let question: String
    var answers: [String: Bool] = [:]
    let book: Int
    let hint: String
    
    enum QuestionKeys: String, CodingKey{
        case id
        case question
        case answer
        case wrong
        case book
        case hint
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QuestionKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        question = try container.decode(String.self, forKey: .question)
        book = try container.decode(Int.self, forKey: .book)
        hint = try container.decode(String.self, forKey: .hint)
        
        // correct answer decoded and added to answers dictionary as true
        let correctAnswer = try container.decode(String.self, forKey: .answer)
        answers[correctAnswer] = true
        
        // wrong answers decoded and added to answers dictionary as false
        let wrongAnswers = try container.decode([String].self, forKey: .wrong)
        for answer in wrongAnswers{
            answers[answer] = false
        }
        
        /*
         answers:
         {
            "The boy who lived" : true,
            "The kid who survived" : false,
            "The baby who beat the dark lord" : false,
            "The Scrawny Teenager" : false
         }
         */
    }
}
