import SwiftUI

struct PastGamesView: View {
    @Environment(\.dismiss)var dismiss

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
                Text("Past Games")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color("fgColor"))
                Spacer()
            }
            Spacer()
//            ForEach(coreDataViewModel.games) { game in
//
//            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BG"))
    }
    
  
    
}

struct PastGamesView_Previews: PreviewProvider {
    static var previews: some View {
        PastGamesView()
    }
}
