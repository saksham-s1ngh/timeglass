//
//  ContentView.swift
//  Timeglass
//
//  Created by Saksham Malhotra on 15/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            VStack{
                HStack {
                    Spacer()
                    Text("THE TIMER GOES HERE")
                        .frame(minWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, minHeight: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(10)
                        .background(
                            Color(#colorLiteral(red: 0.6642268896, green: 0.6642268896, blue: 0.6642268896, alpha: 1)))
                        .cornerRadius(10)
                    Spacer()
                }
                .padding(.top, 10)
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: 500)
                    .padding()
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.3), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 0)
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button("Button 1") {
                        
                    }
                    .padding()
                    .background(
                        Capsule(style: .circular)
                            .fill(Color(#colorLiteral(red: 0.6642268896, green: 0.6642268896, blue: 0.6642268896, alpha: 1)))
                    )
                    
                    Button("Button 2") {
                        
                    }
                    .padding()
                    .background(
                        Capsule(style: .circular)
                            .fill(Color(#colorLiteral(red: 0.6642268896, green: 0.6642268896, blue: 0.6642268896, alpha: 1)))
                    )
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, minHeight: 44)
                .padding()
                .padding(.trailing, 25)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.3), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 0)
                
            }
        }
    }
}

#Preview {
    ContentView()
}
