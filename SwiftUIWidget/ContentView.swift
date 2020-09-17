//
//  ContentView.swift
//  SwiftUIWidget
//
//  Created by Running Raccoon on 2020/09/09.
//  Copyright © 2020 Songkyung Min. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct ContentView: View {
    
    @AppStorage("emoji", store: UserDefaults(suiteName: "group.kr.miiiiiin.SwiftUIWidget"))
    
    var emojiData: Data = Data()
    
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
    
    mutating func save(_ emoji: Emoji) {
        guard let emojiData = try? JSONEncoder().encode(emoji) else { return }
        self.emojiData = emojiData
        
        print("save \(emoji), \(emojiData)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
