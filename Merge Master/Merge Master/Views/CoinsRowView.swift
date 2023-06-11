import SwiftUI

struct CoinsRowView: View {
    @State var price:Double
    @State var coins:Int
    var body: some View {
        HStack{
            Image(systemName: "dollarsign.circle")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color("fgColor"))
            Text("\(coins)")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color("fgColor"))
            Spacer()
            Image(systemName: "dollarsign")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color("fgColor"))
            Text("\(price.formatted())")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color("fgColor"))
        }
    }
}

struct CoinsRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsRowView(price: 1.99, coins: 10)
    }
}
