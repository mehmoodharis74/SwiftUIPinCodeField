# PinCodeTextField

PinCodeTextField is a customizable SwiftUI view for secure input of PINs or codes. It provides a clean and flexible interface for users to type in a PIN, with various customization options including pin length, text style, animation effects, and more.

## Features

- Customizable pin field appearance (shape, size, colors, etc.)
- Supports obscured text (e.g., `*` for PIN entry)
- Configurable cursor animation types (fade or slide)
- Customizable text style (font size, weight, and color)
- Easy to integrate with any SwiftUI view

## Installation

You can add this repository to your project using [Swift Package Manager](https://swift.org/package-manager/).

1. Open Xcode and navigate to your project.
2. Go to `File > Swift Packages > Add Package Dependency`.
3. Paste the URL of this repository (e.g., `https://github.com/yourusername/PinCodeTextField.git`).
4. Select the version or branch you wish to use.

Alternatively, you can manually add the files to your project if you prefer.

## Usage

### Basic Usage

To use `PinCodeTextField`, you can create a `PinCodeTextField` instance within your SwiftUI view and bind it to a string to capture the entered PIN.

```
import SwiftUI
struct ContentView: View {
    @State private var pinCode: String = ""
    var body: some View {
        PinCodeTextField(
            text: $pinCode,
            length: 4, // Number of fields for the PIN
            obscureText: true, // Obscure the entered text
            animationType: .fade, // Cursor animation type
            showCursor: true, // Show the cursor while typing
            cursorColor: .blue, // Cursor color
            spacing: 8.0, // Spacing between fields
            animationDuration: 0.2, // Animation duration
            backgroundColor: .white, // Background color of the input field
            pinTheme: PinTheme(), // Custom pin field theme
            pinTextStyle: PinTextStyle() // Custom text style
        )
    }
}
```
## Customizing the Pin Fields
The `PinCodeTextField` allows you to customize the appearance of the pin fields using the PinTheme class and customize the text style with `PinTextStyle`.

- PinTheme allows customization of the border, background colors, and shape (box or underline).
- PinTextStyle allows customization of font size, weight, and text color.

```
PinCodeTextField(
    text: $pinCode,
    length: 4,
    pinTheme: PinTheme(
        shape: .box, // Box shape for the field
        activeFillColor: .green, // Active fill color
        selectedColor: .red, // Border color when selected
        borderRadius: 10.0 // Rounded corners
    ),
    pinTextStyle: PinTextStyle(
        fontSize: 30, // Font size for the text
        fontWeight: .bold, // Font weight
        textColor: .black // Text color
    )
)
```
## Events
You can define closures for various events:

- onChanged: This closure is called whenever the text in the field changes.
- onCompleted: This closure is called when the pin code input is complete (when the pin length is reached).
```
PinCodeTextField(
    text: $pinCode,
    length: 4,
    onChanged: { newText in
        print("Pin code changed: \(newText)")
    },
    onCompleted: { completedPin in
        print("Pin code completed: \(completedPin)")
    }
)
```

## Customizing the Animation
You can choose between two cursor animations:

- Fade: The cursor will fade in and out.
- Slide: The cursor will slide in and out.
You can customize the animation type with the animationType parameter:
```
PinCodeTextField(
    text: $pinCode,
    length: 4,
    animationType: .slide, // Choose between .fade or .slide
    cursorColor: .blue,
    showCursor: true
)
```

## Requirements
- iOS 13.0+ (or the minimum iOS version required by your project)
- Swift 5.0+
- SwiftUI

## Contributing
We welcome contributions to the project! If you'd like to contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch for your changes (git checkout -b feature-branch).
3. Make your changes and commit them (git commit -am 'Add new feature').
4. Push to your branch (git push origin feature-branch).
4. Open a pull request.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

# Contact
For any issues, suggestions, or questions, feel free to create an issue in the repository or reach out via mehmoodharis74@gmail.com.

