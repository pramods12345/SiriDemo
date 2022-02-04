//
//  IntentHandler.swift
//  PhotoIntent
//
//  Created by PRAMOD S on 17/05/19.
//  Copyright © 2019 PRAMOD S. All rights reserved.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        if(intent is INSearchForMessagesIntent) {
          return MessageIntentHandler()
        }
        return PhotoIntentHandler()
    }
}

class MessageIntentHandler: NSObject, INSearchForMessagesIntentHandling {
    func handle(intent: INSearchForMessagesIntent, completion: @escaping (INSearchForMessagesIntentResponse) -> Void) {
        guard let searchTerm = intent.searchTerms?.first else {
            let response = INSearchForMessagesIntentResponse(code: .failure, userActivity: nil)
            completion(response)
            return
            
        }
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSearchForPhotosIntent.self))
        userActivity.title = searchTerm
        
        let response = INSearchForMessagesIntentResponse(code:
            INSearchForMessagesIntentResponseCode.success,
                                                       userActivity: userActivity)
        completion(response)
    }
}

class PhotoIntentHandler: NSObject, INSearchForPhotosIntentHandling {
   
    func handle(intent: INSearchForPhotosIntent, completion: @escaping (INSearchForPhotosIntentResponse) -> Void) {
        
        guard let searchTerm = intent.searchTerms?.first else {
             let response = INSearchForPhotosIntentResponse(code: .failure, userActivity: nil)
            
            completion(response)
            
            return
            
        }
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSearchForPhotosIntent.self))
        userActivity.title = searchTerm
        
        let response = INSearchForPhotosIntentResponse(code:
            INSearchForPhotosIntentResponseCode.continueInApp,
                                                       userActivity: userActivity)
        completion(response)
    }
    
    func resolveSearchTerms(for intent: INSearchForPhotosIntent, with completion: @escaping ([INStringResolutionResult]) -> Void) {
        let response = INStringResolutionResult.success(with: intent.searchTerms?.first ?? "")
        completion([response])
    }
    
    func confirm(intent: INSearchForPhotosIntent, completion: @escaping (INSearchForPhotosIntentResponse) -> Void) {
        let response = INSearchForPhotosIntentResponse(code: .ready, userActivity: nil)
        completion(response)
    }
}
