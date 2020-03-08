//
//  RecordDisplayViewModel.swift
//  iTranslateSample01
//
//  Created by Sajeev on 3/8/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation

struct RecordDisplayViewModel {
    let name: String
    let duration: String
    
    init(name: String, duration: String) {
        self.name = name
        self.duration = duration
    }
}
