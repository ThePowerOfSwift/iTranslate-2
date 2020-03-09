//
//  DateExtension.swift
//  iTranslate
//
//  Created by Sajeev on 3/9/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation

extension Date {
    func stringValue(format: String? = "yyyy-MM-dd-hh:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
