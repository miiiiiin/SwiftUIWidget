//
//  Emoji.swift
//  SwiftUIWidget
//
//  Created by Running Raccoon on 2020/09/11.
//  Copyright © 2020 Songkyung Min. All rights reserved.
//

import Foundation

struct Emoji: Identifiable, Codable {

    let icon: String
    let name: String
    let description: String
    
    var id: String { icon }
}
