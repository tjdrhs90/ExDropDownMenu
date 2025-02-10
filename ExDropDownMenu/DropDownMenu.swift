//
//  DropDownMenu.swift
//  ExDropDownMenu
//
//  Created by ssg on 2/10/25.
//

import SwiftUI

// https://stackademic.com/blog/swiftui-dropdown-menu-3-ways-picker-menu-and-custom-from-scratch
/// 드롭다운 메뉴
struct DropDownMenu: View {
    
    let placeholder: String
    let options: [String]
    
    var menuWdith: CGFloat? = 150
    var buttonHeight: CGFloat = 50
    var maxItemDisplayed: Int = 3
    
    @Binding var selectedOptionIndex: Int?
    @Binding var showDropdown: Bool
    
    @State private var scrollPosition: Int?
    
    private var menuTitle: String {
        if let selectedOptionIndex {
            options[selectedOptionIndex]
        } else {
            placeholder
        }
    }
    
    var body: some  View {
        VStack(spacing: 0) {
            // selected item
            Button(action: {
                withAnimation {
                    showDropdown.toggle()
                }
            }, label: {
                HStack(spacing: nil) {
                    Text(menuTitle)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees((showDropdown ?  -180 : 0)))
                }
            })
            .padding(.horizontal, 12)
            .frame(height: buttonHeight)
            
            
            // selection menu
            if showDropdown {
                let scrollViewHeight = options.count > maxItemDisplayed ?
                buttonHeight * CGFloat(maxItemDisplayed) + buttonHeight / 2 :
                buttonHeight * CGFloat(options.count)
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(0..<options.count, id: \.self) { index in
                            Button(action: {
                                withAnimation {
                                    selectedOptionIndex = index
                                    showDropdown.toggle()
                                }
                            }, label: {
                                HStack {
                                    Text(options[index])
                                    Spacer()
                                    if (index == selectedOptionIndex) {
                                        Image(systemName: "checkmark.circle.fill")
                                    }
                                }
                                .frame(maxWidth: menuWdith, alignment: .leading)
                                .padding(.horizontal, 12)
                                .frame(height: buttonHeight)
                            })
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollPosition(id: $scrollPosition)
                .scrollDisabled(options.count <= maxItemDisplayed)
                .frame(height: scrollViewHeight)
                .onAppear {
                    scrollPosition = selectedOptionIndex
                }
            }
        }
        .background(.white)
        .clipShape(.rect(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 1)
        }
        .foregroundStyle(.black)
        .font(.callout)
        .frame(maxWidth: menuWdith)
        .frame(height: buttonHeight, alignment: .top) // 높이 제한 시 드롭다운 형식으로 표시되고, 해제 시 스크롤뷰 크기만큼 상위 뷰 늘어남
        .zIndex(100)
    }
}

#Preview {
    @Previewable @State var selectedOptionIndex: Int?
    @Previewable @State var showDropdown =  false
    let fruits = ["apple", "banana", "orange", "kiwi", "cherry", "melon"]
    
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
