import Foundation

/// MARK: - GaugeInterest
public struct GaugeInterest {
    
    /// The base URL for the tracking server
    private static let baseURL = URL(string: "http://localhost:3000/track/")!
    
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
