//
//  EmojiView.swift
//  SwiftUIWidget
//
//  Created by Running Raccoon on 2020/09/11.
//  Copyright © 2020 Songkyung Min. All rights reserved.
//

import SwiftUI

struct EmojiView: View {
    
    let emoji: Emoji!
    
    var body: some View {
        Text(emoji.icon)
            .font(.largeTitle)
        .padding()
            .background(Color.blue)
        .clipShape(Circle())
        
    }
}
