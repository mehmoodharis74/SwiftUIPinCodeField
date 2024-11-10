//// The Swift Programming Language
//// https://docs.swift.org/swift-book
///
import SwiftUI
import Foundation
import Combine
import UIKit


/// A customizable Pin Code Text Field for secure input of PINs or codes.
///
/// This view is designed to provide a clean, customizable input field where users can type in a PIN or code. It supports various customization options such as pin length, text style, animation, and more.
///
/// - Parameters:
///   - text: A binding to the text entered in the pin code field. This is updated as the user types.
///   - length: The length of the pin code (number of fields).
///   - obscureText: A flag that indicates whether the entered text should be obscured (e.g., with `*`).
///   - obscuringCharacter: The character used to obscure the entered text, e.g., `*`.
///   - animationType: The type of animation used for the cursor (e.g., fade, slide).
///   - showCursor: A flag to show or hide the cursor in the text field.
///   - cursorColor: The color of the cursor when visible.
///   - spacing: The spacing between the individual fields for each pin character.
///   - animationDuration: The duration of the cursor animation.
///   - backgroundColor: The background color of the entire pin code field.
///   - enableActiveFill: A flag to enable or disable an active fill color in each pin field.
///   - pinTheme: A custom theme for the pin field, including colors, sizes, and borders.
///   - pinTextStyle: A custom text style for the pin code, including font size and weight.
///   - onChanged: A closure called whenever the text in the field changes. This closure receives the updated text.
///   - onCompleted: A closure called when the pin code input is complete (when the pin length is reached).

public struct PinCodeTextField: View {
    
    @Binding var text: String // The current text entered in the pin code field.
    var length: Int // The number of fields in the pin code input.
    var obscureText: Bool // Flag to obscure the entered text (e.g., replace with `*`).
    var obscuringCharacter: String // The character used to obscure text, default is "*".
    var animationType: AnimationType // The animation type for the cursor (e.g., fade or slide).
    var showCursor: Bool // Whether to show the cursor in the pin code field.
    var cursorColor: Color // The color of the cursor.
    var spacing: Double // The spacing between the pin fields.
    var animationDuration: Double // The duration of the cursor animation.
    var backgroundColor: Color // The background color of the pin code field.
    var enableActiveFill: Bool // Whether to enable an active fill color when text is entered.
    var pinTheme: PinTheme // A custom theme for the pin fields (e.g., colors, borders).
    var pinTextStyle: PinTextStyle // A custom style for the text inside the pin fields.
           
    var onChanged: ((String) -> Void)? = nil // A callback function for text changes.
    var onCompleted: ((String) -> Void)? = nil // A callback function when the pin code is completed (no parameters).

    @FocusState private var isFocused: Bool // Focus state for the text field.
    @State private var internalText: String = "" // Local text holder for internal text management.

    
    /// Initializes a new pin code text field.
    ///
    /// - Parameters:
    ///   - text: A binding to the text entered in the pin code field.
    ///   - length: The number of fields in the pin code input.
    ///   - obscureText: A flag to obscure the entered text (e.g., replace with `*`).
    ///   - obscuringCharacter: The character used to obscure text, default is "*".
    ///   - animationType: The animation type for the cursor (e.g., fade or slide).
    ///   - showCursor: Whether to show the cursor in the pin code field.
    ///   - cursorColor: The color of the cursor.
    ///   - spacing: The spacing between the pin fields.
    ///   - animationDuration: The duration of the cursor animation.
    ///   - backgroundColor: The background color of the pin code field.
    ///   - enableActiveFill: Whether to enable an active fill color when text is entered.
    ///   - pinTheme: A custom theme for the pin fields (e.g., colors, borders).
    ///   - pinTextStyle: A custom style for the text inside the pin fields.
    ///   - onChanged: A closure called whenever the text in the field changes. This closure receives the updated text.
    ///   - onCompleted: A closure called when the pin code input is complete (when the pin length is reached).

    public init(
        text: Binding<String>,
        length: Int,
        obscureText: Bool = false,
        obscuringCharacter: String = "*",
        animationType: AnimationType = .fade,
        showCursor: Bool = true,
        cursorColor: Color = .black,
        spacing: Double = 8.0,
        animationDuration: Double = 0.2,
        backgroundColor: Color = .clear,
        enableActiveFill: Bool = true,
        pinTheme: PinTheme = PinTheme(),
        pinTextStyle: PinTextStyle = PinTextStyle(),
        
        
        onChanged: ((String) -> Void)? = nil,
        onCompleted: ((String) -> Void)? = nil
    ) {
        self._text = text
        self.length = length
        self.obscureText = obscureText
        self.obscuringCharacter = obscuringCharacter
        self.animationType = animationType
        self.showCursor = showCursor
        self.cursorColor = cursorColor
        self.spacing = spacing
        self.animationDuration = animationDuration
        self.backgroundColor = backgroundColor
        self.enableActiveFill = enableActiveFill
        self.pinTheme = pinTheme
        self.pinTextStyle = pinTextStyle
        self.onChanged = onChanged
        self.onCompleted = onCompleted
    }

    public var body: some View {
        ZStack {
            HStack( spacing: spacing) {
                ForEach(0..<length, id: \.self) { index in
                    VStack {
                        ZStack {
                            if enableActiveFill && text.count > index {
                                Rectangle()
                                    .fill(pinTheme.activeFillColor)
                            } else {
                                Rectangle()
                                    .fill(pinTheme.inactiveFillColor)
                            }

                            Text(getText(for: index))
                                .font(.system(size: pinTextStyle.fontSize, weight: pinTextStyle.fontWeight))
                                .foregroundColor(pinTextStyle.textColor)
                            
                            // Show cursor if conditions met
                            if showCursor && isFocused && text.count == index {
                                Rectangle()
                                    .fill(cursorColor)
                                    .frame(width: 2, height: pinTheme.fieldHeight / 2)
                                    .transition(cursorTransition)
                            }
                        }
                        .frame(width: pinTheme.fieldWidth, height: pinTheme.fieldHeight)
                        .background(
                            pinTheme.shape == .box ?
                                AnyView(RoundedRectangle(cornerRadius: pinTheme.borderRadius).fill(pinTheme.inactiveFillColor)) :
                                AnyView(EmptyView())
                        )
                        .overlay(
                            pinTheme.shape == .box ?
                                AnyView(RoundedRectangle(cornerRadius: pinTheme.borderRadius).stroke(getBorderColor(for: index), lineWidth: getBorderWidth(for: index))) :
                                AnyView(EmptyView())
                        )
                        
                        if pinTheme.shape == .underline {
                            Rectangle()
                                .fill(getBorderColor(for: index))
                                .frame(height: getBorderWidth(for: index))
                        }
                    }
                    .frame(width: pinTheme.fieldWidth, height: pinTheme.fieldHeight, alignment: .center)
                }
            }
            .background(backgroundColor)

            // Hidden TextField to capture user input
            TextField("", text: $internalText)
                .keyboardType(.numberPad)
                .foregroundColor(.clear)
                .accentColor(.clear)
                .opacity(0.01) // Make the TextField nearly invisible
                .focused($isFocused)
                .onChange(of: internalText) { newText in
                    if newText.count > length {
                        internalText = String(newText.prefix(length))
                    }
                    withAnimation(cursorAnimation) {
                        text = internalText
                    }
                    onChanged?(text)
                    if text.count == length {
                        onCompleted?(text)
                    }
                }
                .onAppear {
                    internalText = text // Initialize internalText with binding text
                }
        }
        .contentShape(Rectangle()) // Increase the tap area
        .onTapGesture {
            isFocused = true // Focus on tap
        }
    }


    // Define the cursor transition based on the animation type
    private var cursorTransition: AnyTransition {
        switch animationType {
        case .fade:
            return .opacity
        case .slide:
            return .slide
        }
    }

    // Define the cursor animation based on the animation type
    private var cursorAnimation: Animation {
        switch animationType {
        case .fade:
            return .easeInOut(duration: 0.2)
        case .slide:
            return .easeIn(duration: 0.2)
        }
    }

    
    private func getText(for index: Int) -> String {
        guard index < text.count else { return "" }
        
        if obscureText {
            return obscuringCharacter
        } else {
            return String(text[text.index(text.startIndex, offsetBy: index)])
        }
    }
    
    private func getBorderColor(for index: Int) -> Color {
        if text.count > index {
            return pinTheme.activeColor
        } else if isFocused {
            return pinTheme.selectedColor
        } else {
            return pinTheme.inactiveColor
        }
    }
    
    private func getBorderWidth(for index: Int) -> CGFloat {
        if text.count > index {
            return pinTheme.selectedBorderWidth
        } else {
            return pinTheme.inactiveBorderWidth
        }
    }
   
}
