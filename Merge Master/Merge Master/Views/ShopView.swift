import SwiftUI

struct ShopView: View {
    @EnvironmentObject var shopViewModel:ShopViewModel
    @EnvironmentObject var userViewModel:UserViewModel
    @EnvironmentObject var musicViewModel:MusicViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            HStack{
                Button {
                    musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color("fgColor"))
                }
                
                Spacer()
                Text("Shop")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color("fgColor"))
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
            ScrollView(showsIndicators: false) {
                VStack{
                    if shopViewModel.items.isEmpty{
                        Text("You've bought everything from the shop")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color("fgColor"))
                            .frame(height: UIScreen.main.bounds.height * 0.7)
                    }
                    ForEach(shopViewModel.items, id: \.self){item in
                        if let index = userViewModel.user.powerups.firstIndex(of: item.powerUp){
                            
                        }
                        else{
                            NavigationLink {
                                ShopItemView(item: item)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                ShopItemRow(item: item)
                            }
                            .padding(.vertical)
                            .onTapGesture {
                                musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color("BG"))
    }
}

struct ShopView_Previews: PreviewProvider {
    static let vm = ShopViewModel()
    static let vm1 = UserViewModel()
    static let vm2 = MusicViewModel()
    static var previews: some View {
        ShopView()
            .environmentObject(vm)
            .environmentObject(vm1)
            .environmentObject(vm2)
    }
}
