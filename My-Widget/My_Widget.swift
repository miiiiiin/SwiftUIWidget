//
//  My_Widget.swift
//  My-Widget
//
//  Created by Running Raccoon on 2020/09/17.
//  Copyright © 2020 Songkyung Min. All rights reserved.
//

import WidgetKit
import SwiftUI

struct EmojiEntry: TimelineEntry {
    let date = Date()
    let emoji: Emoji
}

struct Provider: TimelineProvider {
    
    typealias Entry = EmojiEntry
    
    @AppStorage("emoji", store: UserDefaults(suiteName: "group.kr.miiiiiin.SwiftUIWidget"))
    var emojiData: Data = Data()
    
    func placeholder(in context: Context) -> EmojiEntry {
        guard let emoji = try? JSONDecoder().decode(Emoji.self, from: emojiData) else { return EmojiEntry(emoji: Emoji(icon: "😊", name: "N/A", description: "N/A")) }
        let entry = EmojiEntry(emoji: emoji)
        return entry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (EmojiEntry) -> Void) {
        guard let emoji = try? JSONDecoder().decode(Emoji.self, from: emojiData) else { return }
        let entry = EmojiEntry(emoji: emoji)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<EmojiEntry>) -> Void) {
        guard let emoji = try? JSONDecoder().decode(Emoji.self, from: emojiData) else { return }
        let entry = EmojiEntry(emoji: emoji)
        let timeLine = Timeline(entries: [entry], policy: .never)
        completion(timeLine)
    }
}

struct PlaceholderView: View {
    var body: some View {
        EmojiView(
            emoji: Emoji(icon: "😊", name: "N/A", description: "N/A")
        )
    }
}

struct WidgetEntryView: View {
    let entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder //it will allow to use if or switch statements inside of our view
    var body: some View {
        
        switch family {
        case .systemSmall:
            EmojiView(emoji: entry.emoji)
            
        case .systemMedium:
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30, content: {
                EmojiView(emoji: entry.emoji)
                
                Text(entry.emoji.name)
                    .font(.largeTitle)
                
            })
        default:
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30, content: {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30, content: {
                    EmojiView(emoji: entry.emoji)
                    
                    Text(entry.emoji.name)
                        .font(.largeTitle)
                    
                })
                Text(entry.emoji.description)
                    .font(.title)
                    .padding()
            })
        }
    }
}

@main //to the extension knows that this is main function
struct MyWidget: Widget {
    private let kind = "My_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
