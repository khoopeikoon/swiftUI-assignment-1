//
//  ContentView.swift
//  Learning app 1
//
//  Created by Khoo Pei Koon on 10/4/24.
//

import SwiftUI

struct ContentView: View {
//    let emojis: Array<String> = ["🥲","🤔","🙄","🤣","🥹","🥳","🤩"]
//    let vehicles: Array<String> = ["🚗", "🚘", "🚙", "🚚", "🚛", "⛴️", "✈️"]
    @State var cardCount: Int = 6
    @State private var currentTheme: Theme = .emojis
    
    enum Theme: CaseIterable {
        case emojis
        case vehicles
        case halloween
        
        var images: [String] {
            switch self {
            case .emojis:
                return ["😀", "😃", "😄", "😁", "😆", "😅", "😂"]
            case .vehicles:
                return ["🚗", "🚘", "🚙", "🚚", "🚛", "⛴️", "✈️"]
            case .halloween:
                return ["😈", "🎃","🧙","🍬","🕸️","🍁","👻"]
            }
        }
    }
    
    
    var body: some View {
        VStack{
            Text("Memorize")
                .font(.system(size: 70))
                .aspectRatio(1, contentMode: .fit)
            ScrollView{
                cards
            }
            cardCountAdjusters
        }
        .padding()
    }
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))])
        {
            ForEach(0..<cardCount,id: \.self) { index in
                CardView(content:currentTheme.images[index % currentTheme.images.count])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.blue)
    }
    
    var cardCountAdjusters: some View {
        HStack{
//            cardAdder
//            Spacer()
//            cardRemover
            facesTheme
            Spacer()
            vehiclesTheme
            Spacer()
            halloweenTheme
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    func cardThemeAdjuster (for theme: Theme, symbol: String, label: String) -> some View {
        Button(action: {
            currentTheme = theme
        }) {
            VStack{
                Image(systemName: symbol)
                Text(label)
                    .font(.caption)
                    .aspectRatio(1 ,contentMode: .fit)
            }
        }
    }
    var facesTheme: some View{
            cardThemeAdjuster(for: .emojis, symbol: "person", label: "Emojis")
    }
    var vehiclesTheme: some View{
            cardThemeAdjuster(for: .vehicles, symbol: "car", label: "Vehicles")
    }
    var halloweenTheme: some View{
            cardThemeAdjuster(for: .halloween, symbol: "bolt.fill", label: "Halloween")
    }
    
//    func cardCountAdjuster (by offset: Int, symbol: String) -> some View {
//        Button(action: {
//            cardCount += offset
//        }, label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset >  emojis.count)
//    }
//    var cardRemover: some View{
//        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//    }
//    var cardAdder: some View {
//        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
//    }
}
struct CardView: View {
    let content:String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius:15)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth:5)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
