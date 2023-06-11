import SwiftUI

struct ContentView: View {

    var body: some View {
        ZStack {
            Color.black
            
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.7, green: 0, blue: 0), Color(red: 0.5, green: 0, blue: 0)]), startPoint: .top, endPoint: .bottom)
                .opacity(0.7)
            
            Circle()
                .foregroundColor(Color(red: 0.2, green: 0, blue: 0))
                .frame(width: 800, height: 800)
                .blur(radius: 300)
            
            Circle()
                .foregroundColor(Color(red: 0.5, green: 0, blue: 0))
                .frame(width: 600, height: 600)
                .blur(radius: 150)
            
            Circle()
                .foregroundColor(Color(red: 0.7, green: 0, blue: 0))
                .frame(width: 400, height: 400)
                .blur(radius: 50)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
