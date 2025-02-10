//
//  ContentView.swift
//  ExDropDownMenu
//
//  Created by ssg on 2/10/25.
//

import SwiftUI

struct ContentView: View {
    @State var selectedOptionIndex: Int?
    @State var showDropdown =  false
    let fruits = ["apple", "banana", "orange", "kiwi", "cherry", "melon"]
    
    
    var body: some View {
        ZStack {
            DropDownMenu(
                placeholder: "메뉴 선택",
                options: fruits,
                selectedOptionIndex: $selectedOptionIndex,
                showDropdown: $showDropdown
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .onTapGesture {
            withAnimation {
                showDropdown =  false
            }
        }
    }
}

#Preview {
    ContentView()
}
