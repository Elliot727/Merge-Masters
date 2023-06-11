import SwiftUI

struct HomeView: View {
    @EnvironmentObject var musicViewModel:MusicViewModel
    var body: some View {
        NavigationStack{
            VStack{
                Text("2048")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(Color("fgColor"))
                Spacer()
                VStack(spacing:10){
                    NavigationLink {
                        SelectGridSizeView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Start")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(Color("fgColor"))
                    }
                    .onTapGesture {
                        musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                    }
                    NavigationLink {
                        PastGamesView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Past Games")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(Color("fgColor"))
                    }
                    .onTapGesture {
                        musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                    }
                    NavigationLink {
                        ShopView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Shop")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(Color("fgColor")) 
                    }
                    .onTapGesture {
                        musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                    }
                    NavigationLink {
                        UserView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("User")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(Color("fgColor"))
                    }
                    .onTapGesture {
                        musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                    }
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BG"))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static let vm = MusicViewModel()
    static var previews: some View {
        HomeView()
            .environmentObject(vm)
    }
}
