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
    
    var body: some View {
        EmojiView(emoji: entry.emoji)
    }
}

@main //to the extension knows that this is main function
struct MyWidget: Widget {
    private let kind = "My_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
    }
}
