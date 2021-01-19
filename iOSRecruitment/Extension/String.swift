//
//  String.swift
//  iOSRecruitment
//
//  Created by Rodolphe Schnetzer on 19/01/2021.
//  Copyright © 2021 cheerz. All rights reserved.
//

import Foundation

extension String { 
    // Check if a string contains at least one element
    
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces) == String() ? true : false
    }
    
}
