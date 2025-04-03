### Guage Interest Swift Package

A lightweight event tracking Swift package that respects privacy and retains complete anonymity.

### Add package

1. Add Gauge Interest to your Xcode project: `https://github.com/AdamWhitcroft/gauge-interest-swift-package/`

### Usage example

```
import SwiftUI
import GaugeInterest

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Are you interested?")
            
            Button {
                GaugeInterest.baseURL = URL(string: "your-event-string-here")!

                GaugeInterest.track("test-button") { success in
                    print("Status: \(success)")
                }
            } label: {
                Text("Press Me")
            }
        }
    }
}

```
