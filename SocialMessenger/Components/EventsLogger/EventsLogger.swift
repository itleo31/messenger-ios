//
//  EventsLogger.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 9/1/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import FacebookCore

class EventsLogger: EventsLogging {
    
    func activate(_ application: UIApplication) {
        AppEventsLogger.activate(application)
    }
}
