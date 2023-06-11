import SwiftUI

struct AddUsernameView: View {
    @State var isPresented:Bool = false
    @State var username:String = ""
    @EnvironmentObject var userViewModel:UserViewModel
    @AppStorage("isLoggedIn") var isLoggedIn = false
    var body: some View {
        VStack{
            Spacer()
            TextField("Choose a username", text: $username)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(Color("fgColor"))
                .padding()
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("fgColor"), style: StrokeStyle(lineWidth: 2))
                })
                .padding()
            Spacer()
            Button {
                userViewModel.user.username = username.isEmpty ? "User":username
                isLoggedIn.toggle()
                isPresented.toggle()
               
            } label: {
                Text("Next")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Color("fgColor"))
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .background(Color("BG"))
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("fgColor"), style: StrokeStyle(lineWidth: 2))
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                    })
            }
            .fullScreenCover(isPresented: $isPresented) {
                HomeView()
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BG"))
    }
}

struct AddUsernameView_Previews: PreviewProvider {
    static let vm = UserViewModel()
    static var previews: some View {
        AddUsernameView()
            .environmentObject(vm)
    }
}
