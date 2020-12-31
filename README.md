# Eat List

Eat List is an app that allows you to find trending restaurants around your area. It's fast, beautiful, and simple - perfect for finding new restaurants without the hassle of typing in keywords or tapping on different categories. 

## Description
Eat List uses the user's location, then connects to Zomato's APIs to find the trending restaurants around that area. It has a relatively minimalistic UI, so it has no sorting/filtering options.  

## Libraries Used

To speed up development and improve code quality, the following libraries were integrated into the app:

- Moya - For cleaner encapsulation of network code
- Kingfisher - For clean and fast fetching and caching of images from URLs
- Hero - For more seamless animations between screens
- Realm and Unrealm - Persistence libraries for fast and reliable storage. Unrealm was added because it allows for minimal code changes to default codable objects, and can quickly be swapped out and removed as needed. Opting for Realm only would mean having to add "dynamic" keywords to the models among other required changes, which could quickly become unwieldy over time, while also coupling the models too much to a specific library.
- R.Swift - Allows for a much cleaner code due to the strongly-typed generated code for nibs, storyboards, etc. 
- SwiftLint - Prevents code from deviating from accepted and recommended conventions. 


## Installation

This project uses Swift Package Manager for most of its dependencies, but for SwiftLint and R.Swift, which both rely on build scripts to work properly, CocoaPods is still used. 

In the project's root directory, run the following command:

```bash
pod install
```

## Notes

- There's currently a known issue wherein when the user reaches the last element, the list scrolls back to the top part. 
- If running on the simulator, you'll likely notice a more prominent stutter from apple maps. This is natural and should not happen in the physical device.

## License
[MIT](https://choosealicense.com/licenses/mit/)
