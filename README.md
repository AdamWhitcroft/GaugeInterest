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
            Button {
                GaugeInterest.track("cookie-don-fcdm") { success in
                    if success {
                        print("✅ Tap registered")
                    } else {
                        print("❌ Failed to register tap")
                    }
                }
            } label: {
                Text("Push me")
            }
        }
        .padding()
    }
}
```
