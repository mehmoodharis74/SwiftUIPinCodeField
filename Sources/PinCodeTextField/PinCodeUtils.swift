//
//  PinCodeUtils.swift
//  PinCodeTextField
//
//  Created by Haris  on 10/11/2024.
//

import Foundation
import SwiftUI

/// Defines the appearance of the pin code text fields, including colors, borders, and shapes.
///
/// Use this struct to customize the visual styling of each pin code field in the `PinCodeTextField`. It allows you to control aspects like border radius, background colors, and field size.
///
/// - Parameters:
///   - activeFillColor: The fill color when the pin field is active (i.e., text is entered).
///   - selectedFillColor: The fill color then the container is active.
///   - inactiveFillColor: The fill color when the pin field is inactive.
///   - activeBorderColor: The border color when the pin field is active.
///   - inactiveBorderColor: The border color when the pin field is inactive.
///   - selectedColor: The color of the border when the pin field is active.
///   - inactiveColor: The color of the border when the pin field is inactive.
///   - activeBorderWidth: The border width when the pin field is active.
///   - inactiveBorderWidth: The border width when the pin field is inactive.
///   - shape: The shape of the pin code field (either box or underline).
///   - borderRadius: The corner radius of the pin fields when the shape is box.
///   - fieldHeight: The height of each individual pin field.
///   - fieldWidth: The width of each individual pin field.

public class PinTheme : ObservableObject {
    @Published var shape: PinCodeFieldShape
    @Published var borderRadius: CGFloat
    @Published var fieldHeight: CGFloat
    @Published var fieldWidth: CGFloat
    @Published var activeFillColor: Color
    @Published var selectedFillColor: Color
    @Published var inactiveFillColor: Color
    @Published var activeColor: Color
    @Published var selectedColor: Color
    @Published var inactiveColor: Color
    @Published var selectedBorderWidth: CGFloat
    @Published var inactiveBorderWidth: CGFloat

    public init(
        shape: PinCodeFieldShape = .box,
        borderRadius: CGFloat = 8.0,
        fieldHeight: CGFloat = 50,
        fieldWidth: CGFloat = 50,
        activeFillColor: Color = .clear,
        selectedFillColor: Color = .clear,
        inactiveFillColor: Color = .clear,
        activeColor: Color = .blue,
        selectedColor: Color = .blue,
        inactiveColor: Color = .gray,
        selectedBorderWidth: CGFloat = 2.2,
        inactiveBorderWidth: CGFloat = 2
    ) {
        self.shape = shape
        self.borderRadius = borderRadius
        self.fieldHeight = fieldHeight
        self.fieldWidth = fieldWidth
        self.activeFillColor = activeFillColor
        self.selectedFillColor = selectedFillColor
        self.inactiveFillColor = inactiveFillColor
        self.activeColor = activeColor
        self.selectedColor = selectedColor
        self.inactiveColor = inactiveColor
        self.selectedBorderWidth = selectedBorderWidth
        self.inactiveBorderWidth = inactiveBorderWidth
    }
}

/// Defines the text style applied to the text in each pin field.
///
/// This struct allows you to customize the font style, size, and color of the pin code text inside the input fields.
///
/// - Parameters:
///   - fontSize: The font size of the pin text.
///   - fontWeight: The weight (boldness) of the font.
///   - textColor: The color of the pin text.


public class PinTextStyle {
    var fontSize: CGFloat
    var fontWeight: Font.Weight
    var textColor: Color

    public init(
        fontSize: CGFloat = 24,
        fontWeight: Font.Weight = .semibold,
        textColor: Color = .black
    ) {
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.textColor = textColor
    }
}

/// Enum to define the shape of pin code fields
public enum PinCodeFieldShape {
    case box, underline
}

/// Enum for animation types
public enum AnimationType {
    case fade, slide
}
