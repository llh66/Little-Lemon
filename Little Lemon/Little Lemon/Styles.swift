//
//  Styles.swift
//  Little Lemon
//
//  Created by LLH on 2024-08-21.
//

import SwiftUI

public extension Color {
    static let primaryColor1 = Color(red: 0.28627450980392155, green: 0.3686274509803922, blue: 0.3411764705882353)
    static let primaryColor2 = Color(red: 0.9568627450980393, green: 0.807843137254902, blue: 0.0784313725490196)
}

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square.fill")
                configuration.label
            }
        })
        .foregroundColor(Color.primaryColor1)
        .padding(.vertical, 1)
    }
}
