//
//  TextHelper.swift
//  CitySights
//
//  Created by Tauan Tathiell Camargo on 04/07/24.
//

import Foundation

struct TextHelper {
    static func distanceAwayText(meters: Double) -> String {
        if meters > 1000 {
            return "\(Int(round(meters / 1000))) k away"
        } else {
            return "\(Int(round(meters))) m away"
        }
    }
}
