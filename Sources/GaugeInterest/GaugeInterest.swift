import Foundation

/// MARK: - GaugeInterest
public enum GaugeInterest {

    // MARK: - Internal Constants

    /// 🔐 Supabase project URL
    private static let supabaseURL = URL(string: "https://hhwvinjccespcliewifd.supabase.co")!
    /// 🟡 Your project’s anon key
    private static let supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhod3ZpbmpjY2VzcGNsaWV3aWZkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM3MjQ1NzEsImV4cCI6MjA1OTMwMDU3MX0.pNDC5Z2qGjFKZhsBE4Yi-Mzkc2ZzHgPxWlvAMT2I3C0"

    // MARK: - Configurable State

    /// 🔐 Developer's private API key (not used for auth — used in body)
    private static var apiKey: String?

    /// Configure with a developer-specific API key
    public static func configure(apiKey: String) {
        self.apiKey = apiKey
    }

    /// Tracks a tap on an event by slug
    public static func track(_ eventSlug: String, completion: ((Bool) -> Void)? = nil) {
        guard let apiKey else {
            print("[GaugeInterest] Error: No API key set. Did you call configure(apiKey:)?")
            completion?(false)
            return
        }

        print("[GaugeInterest] Using API key:", apiKey)

        let url = supabaseURL.appendingPathComponent("/rest/v1/rpc/track_event")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(supabaseAnonKey)", forHTTPHeaderField: "Authorization")
        request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")

        let body: [String: String] = [
            "api_key_param": apiKey,
            "slug_param": eventSlug
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

    let success = ((response as? HTTPURLResponse)?.statusCode == 200 || (response as? HTTPURLResponse)?.statusCode == 201)
        && error == nil

    DispatchQueue.main.async {
        completion?(success)
    }
}.resume()

    }
}
