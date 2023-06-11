import SwiftUI

struct ShopItemView: View {
    @Environment(\.dismiss) var dismiss
    var item:ShopItemModel
    @EnvironmentObject var userViewModel:UserViewModel
    @EnvironmentObject var shopViewModel:ShopViewModel
    @EnvironmentObject var musicViewModel:MusicViewModel
    @State var showAlert:Bool = false
    var body: some View {
        ZStack {
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
                    Image(systemName: "dollarsign.circle")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(Color("fgColor"))
                    NavigationLink {
                        BuyCoinsView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("\(userViewModel.user.coins)")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color("fgColor"))
                    }

                }
                .padding(.bottom)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20){
                        Image(systemName: item.powerUp.image)
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(Color("fgColor"))
                        Text(item.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color("fgColor"))
                        Text(item.desc)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("fgColor"))
                        HStack{
                            Image(systemName: "dollarsign.circle")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(Color("fgColor"))
                            Text("\(item.coins) coins")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color("fgColor"))
                            Spacer()
                            
                        }
                    }
                }
                Button {
                    if userViewModel.user.coins < item.coins{
                        withAnimation(.easeIn){
                            showAlert.toggle()
                        }
                    }
                    else{
                        musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                        userViewModel.user.coins -= item.coins
                        userViewModel.user.powerups.append(item.powerUp)
                        if let index = shopViewModel.items.firstIndex(of: item){
                            shopViewModel.items.remove(at: index)
                        }
                        dismiss()
                    }
                } label: {
                    Text("Buy")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(Color("BG"))
                        .padding()
                        .frame(width: UIScreen.main.bounds.width * 0.9)
                        .background(Color("fgColor"))
                        .cornerRadius(20)
                }
            }
            .padding()
            .background(Color("BG"))
            .blur(radius: showAlert ? 15:0)
            .disabled(showAlert)
            if showAlert{
                CustomAlertView(showAlert: $showAlert)
            }
        }
    }
}

struct ShopItemView_Previews: PreviewProvider {
    static let vm = UserViewModel()
    static let vm1 = ShopViewModel()
    static let vm2 = MusicViewModel()
    static var previews: some View {
        ShopItemView(item: ShopItemModel(powerUp: PowerUpTile(type: .multiplier), name: "Multiplier", desc: "Multiplies your score by 2 for 5 seconds", coins: 10))
            .environmentObject(vm)
            .environmentObject(vm1)
            .environmentObject(vm2)
    }
}
