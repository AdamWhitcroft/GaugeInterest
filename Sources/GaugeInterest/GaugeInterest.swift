import Foundation

/// MARK: - GaugeInterest
public enum GaugeInterest {

    // MARK: - Internal Constants

    /// 🔐 Supabase project URL
    private static let supabaseURL = URL(string: "https://hhwvinjccespcliewifd.supabase.co")!

    // MARK: - Configurable State

    /// 🔐 Developer's private API key
    private static var apiKey: String?

    /// Configure with a developer-specific API key
    public static func configure(apiKey: String) {
        self.apiKey = apiKey
    }

    /// Tracks a tap on an event by slug
    /// - Parameters:
    ///   - eventSlug: The unique event slug (e.g. "home-button")
    ///   - completion: Optional result callback (success = true/false)
    public static func track(_ eventSlug: String, completion: ((Bool) -> Void)? = nil) {
        guard let apiKey else {
            print("[GaugeInterest] Error: No API key set. Did you call configure(apiKey:)?")
            completion?(false)
            return
        }

        let url = supabaseURL.appendingPathComponent("/rest/v1/rpc/track_event")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        request.setValue("return=minimal", forHTTPHeaderField: "Prefer")

        let body: [String: String] = [
            "slug": eventSlug,
            "api_key": apiKey
        ]
        
        request.httpBody = try? JSONEncoder().encode(body)

        print("[GaugeInterest] Tracking event for slug:", eventSlug)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let http = response as? HTTPURLResponse {
                print("[GaugeInterest] Status code:", http.statusCode)
            }
            if let error = error {
                print("[GaugeInterest] Error:", error.localizedDescription)
            }
            if let data = data, let body = String(data: data, encoding: .utf8) {
                print("[GaugeInterest] Response body:", body)
            }

            let success = (response as? HTTPURLResponse)?.statusCode == 201 && error == nil
            DispatchQueue.main.async {
                completion?(success)
            }
        }.resume()
    }
}
