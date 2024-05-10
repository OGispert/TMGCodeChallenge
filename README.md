# TMGCodeChallenge

TMG Code Challenge


## Architecture
I decided to create this project using MVVM as design pattern.

I also included a network helper, using protocol oriented programing, and dependency injection for the details view.


## Tools
- Xcode 15.3
- Swift 5
- Minimun deployment target: iOS 15 (according to requirements)


## TO RUN

- Go to NetworkHekper.swift, line 18, and add your Weather API token.
- Build.


## Console log
I am getting the following console warning:

-[RTIInputSystemClient remoteTextInputSessionWithID:performInputOperation:]  perform input operation requires a valid sessionID. inputModality = Keyboard, inputOperation = <null selector>, customInfoType = UIEmojiSearchOperations

I found that this is an issue only happening in simulators in iOS 17, and does not affect nor is created by the application.

Reference: https://forums.developer.apple.com/forums/thread/731700


## :)
I hope you like it as much as I liked working on it.
