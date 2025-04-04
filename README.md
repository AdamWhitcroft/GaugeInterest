### Guage Interest Swift Package

A lightweight event tracking Swift package that respects privacy and retains complete anonymity.

### Add package

1. Add Gauge Interest to your Xcode project: `https://github.com/AdamWhitcroft/gauge-interest-swift-package/`

### Usage example

```
import SwiftUI
import GaugeInterest

@main
struct MyApp: App {
    init() {
        GaugeInterest.configure(apiKey: "user-api-key-abc123")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

And to track:

```
GaugeInterest.track("YOUR-EVENT-SLUG")
```

There's also a callback for successful event logging:

```
GaugeInterest.track("YOUR-EVENT-SLUG") { success in
    if success {
        print("Success")
    }
}
```