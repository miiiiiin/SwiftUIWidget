//
//  ContentView.swift
//  SwiftUIWidget
//
//  Created by Running Raccoon on 2020/09/09.
//  Copyright © 2020 Songkyung Min. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let emojis = [
        Emoji(icon: "😊", name: "Happy", description: "happy"),
        Emoji(icon: "👿", name: "Angry", description: "Angry"),
        Emoji(icon: "🥴", name: "Boring", description: "Boring")
    ]
    
    var body: some View {
        VStack(spacing: 30) {
            ForEach(emojis) { emoji in
                EmojiView(emoji: emoji)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
