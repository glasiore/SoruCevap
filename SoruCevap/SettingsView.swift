import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section(header: Text("İletişim")) {
                NavigationLink("Bize Ulaşın", destination: ContactUsView())
            }
            
            Section(header: Text("Yasal")) {
                NavigationLink("Kullanım Şartları", destination: TermsView())
                NavigationLink("Gizlilik Politikası", destination: PrivacyPolicyView())
            }
        }
        .navigationTitle("Ayarlar")
    }
} 
