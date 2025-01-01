import SwiftUI

struct TermsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Kullanım Koşulları")
                    .font(.title)
                    .foregroundColor(.blue)
                
                Text("1. Genel Kurallar")
                    .font(.headline)
                Text("Bu uygulamayı kullanarak aşağıdaki koşulları kabul etmiş sayılırsınız...")
                
                Text("2. Sorumluluk Reddi")
                    .font(.headline)
                Text("Uygulama içeriğindeki bilgilerin doğruluğu konusunda...")
                
                Text("3. Telif Hakları")
                    .font(.headline)
                Text("Tüm içerik telif hakları ile korunmaktadır...")
            }
            .padding()
        }
        .navigationTitle("Kullanım Koşulları")
    }
} 