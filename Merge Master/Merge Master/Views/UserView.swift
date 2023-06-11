import SwiftUI

struct UserView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userViewModel:UserViewModel
    var body: some View {
        VStack{
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color("fgColor"))
                }
                Spacer()
                Text(userViewModel.user.username)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color("fgColor"))
                Spacer()
            }
            .padding(.horizontal)
            Spacer()
            ForEach(userViewModel.user.powerups){powerUp in
                Text(powerUp.image)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BG"))
    }
}

struct UserView_Previews: PreviewProvider {
    static let vm = UserViewModel()
    static var previews: some View {
        UserView()
            .environmentObject(vm)
    }
}
