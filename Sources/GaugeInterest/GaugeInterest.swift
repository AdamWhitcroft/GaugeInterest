import Foundation

/// MARK: - GaugeInterest
public struct GaugeInterest {
    
    /// Configure GaugeInterest endpoint
    public static var baseURL: URL = URL(string: "https://example.com/track/")!
    
    /// Track a button tap event
    /// - Parameters:
    ///   - eventID: A unique string representing this tap event
    ///   - completion: Optional callback to confirm event was received
    public static func track(_ eventID: String, completion: ((Bool) -> Void)? = nil) {
        let url = baseURL.appendingPathComponent(eventID)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            let success = (response as? HTTPURLResponse)?.statusCode == 200 && error == nil
            DispatchQueue.main.async {
                completion?(success)
            }
        }
        
        task.resume()
    }
}
