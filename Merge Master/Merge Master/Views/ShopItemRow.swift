import SwiftUI

struct ShopItemRow: View {
    var item:ShopItemModel
    var body: some View {
        HStack{
            Image(systemName: item.powerUp.image)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(Color("fgColor"))
            Text(item.name)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(Color("fgColor"))
            Spacer()
            Text("\(item.coins) coins")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color("fgColor"))
        }
    }
}

struct ShopItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ShopItemRow(item: ShopItemModel(powerUp: PowerUpTile(type: .multiplier), name: "Multiplier", desc: "Multiplies your score by 2 for 5 seconds", coins: 10))
    }
}
