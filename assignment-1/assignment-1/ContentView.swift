//
//  ContentView.swift
//  Learning app 1
//
//  Created by Khoo Pei Koon on 10/4/24.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["🥲","🤔","🙄","🤣","🥹","🥳","🤩"]
    @State var cardCount: Int = 6
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
                CardView(content:emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.blue)
    }
    
    var cardCountAdjusters: some View {
        HStack{
            cardAdder
            Spacer()
            cardRemover
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster (by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset >  emojis.count)
    }
    var cardRemover: some View{
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
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
