import Foundation

/// MARK: - GaugeInterest
public struct GaugeInterest {
    
    // MARK: - Internal Constants
    
    /// 🔐 Your Supabase project URL (hardcoded)
    private static let supabaseURL = URL(string: "https://hhwvinjccespcliewifd.supabase.co")!
    
    /// 🔐 Your Supabase anon public key (hardcoded)
    private static let anonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhod3ZpbmpjY2VzcGNsaWV3aWZkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM3MjQ1NzEsImV4cCI6MjA1OTMwMDU3MX0.pNDC5Z2qGjFKZhsBE4Yi-Mzkc2ZzHgPxWlvAMT2I3C0"

    // MARK: - Public API

    /// Tracks a tap on an event by slug
    /// - Parameters:
    ///   - eventSlug: The unique event slug (e.g. "home-button")
    ///   - completion: Optional result callback (success = true/false)
    public static func track(_ eventSlug: String, completion: ((Bool) -> Void)? = nil) {
        let url = supabaseURL.appendingPathComponent("/rest/v1/event_hits")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(anonKey)", forHTTPHeaderField: "Authorization")
        request.setValue("return=minimal", forHTTPHeaderField: "Prefer")

        let body: [String: String] = ["event_slug": eventSlug]
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            let success = (response as? HTTPURLResponse)?.statusCode == 201 && error == nil
            DispatchQueue.main.async {
                completion?(success)
            }
        }.resume()
    }
}
