import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, World! \(Environment.apiBaseUrl)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

enum Environment {
    enum Keys {
        static let apiBaseUrl = "API_BASE_URL"
    }
    
    private static let infoDisctionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dict
    }()
    
    static let apiBaseUrl: String = {
        guard let apiKeyString = Environment.infoDisctionary[Keys.apiBaseUrl] as? String else {
            fatalError("API Key not set in plist")
        }
        return apiKeyString
    }()
}
