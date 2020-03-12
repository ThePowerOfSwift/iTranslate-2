//
//  TimeIntervalExtension.swift
//  LiveStyledTest
//
//  Created by Sajeev on 3/8/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import UIKit

extension TimeInterval {
    func stringValue() -> String {
        
        let time = NSInteger(self)
        
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds) as String
    }
}
