import SwiftUI

struct BuyCoinsView: View {
    @EnvironmentObject var userViewModel:UserViewModel
    @Environment(\.dismiss) var dismiss
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
                Text("Buy Coins")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Color("fgColor"))
                Spacer()
                Image(systemName: "dollarsign.circle")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Color("fgColor"))
                Text("\(userViewModel.user.coins)")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Color("fgColor"))
            }
            ScrollView(showsIndicators: false) {
                VStack(spacing:20){
                    Button {
                        
                    } label: {
                        CoinsRowView(price: 1.99, coins: 10)
                    }
                    Button {
                        
                    } label: {
                        CoinsRowView(price: 1.99, coins: 10)
                    }
                    Button {
                        
                    } label: {
                        CoinsRowView(price: 1.99, coins: 10)
                    }
                    Button {
                        
                    } label: {
                        CoinsRowView(price: 1.99, coins: 10)
                    }
                }
            }
            .padding(.vertical)
            
        }
        .padding()
        .background(Color("BG"))
    }
}

struct BuyCoinsView_Previews: PreviewProvider {
    static let vm = UserViewModel()
    static var previews: some View {
        BuyCoinsView()
            .environmentObject(vm)
    }
}
