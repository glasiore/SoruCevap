import SwiftUI

struct ContactUsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("İletişim")
                .font(.title)
                .foregroundColor(.blue)
            
            Text("Bize ulaşmak için:")
                .font(.headline)
            
            Text("Email: emre@guclu.kim")
            Text("Tel: +49 1573 4425751")
            
            Link("Web Sitemiz", destination: URL(string: "https://www.guclu.kim")!)
                .foregroundColor(.blue)
        }
        .padding()
        .navigationTitle("İletişim")
    }
} 
