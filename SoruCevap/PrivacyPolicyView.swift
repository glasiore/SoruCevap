import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Gizlilik Politikası")
                    .font(.title)
                    .foregroundColor(.blue)
                
                Text("Veri Toplama")
                    .font(.headline)
                Text("Uygulamamız kullanıcı verilerini nasıl topladığı...")
                
                Text("Veri Kullanımı")
                    .font(.headline)
                Text("Toplanan verilerin nasıl kullanıldığı...")
                
                Text("Veri Güvenliği")
                    .font(.headline)
                Text("Verilerinizin nasıl korunduğu...")
            }
            .padding()
        }
        .navigationTitle("Gizlilik Politikası")
    }
} 