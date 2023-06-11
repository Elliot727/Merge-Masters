import SwiftUI

struct CustomAlertView: View {
    @Binding var showAlert:Bool
    var body: some View {
        VStack{
            Text("You don't have enought coins for that yet")
                .multilineTextAlignment(.center)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(Color("BG"))
                .padding(.top)
            Spacer()
            Image(systemName: "dollarsign.circle")
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(Color("BG"))
            Spacer()
            Button {
                withAnimation(.easeOut){
                    showAlert.toggle()
                }
            } label: {
                Text("Dismiss")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("fgColor"))
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.5)
                    .background(Color("BG"))
                    .cornerRadius(10)
            }
            .padding(.bottom)

        }
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 300)
        .background(Color("fgColor"))
        .cornerRadius(20)
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(showAlert: .constant(true))
    }
}
