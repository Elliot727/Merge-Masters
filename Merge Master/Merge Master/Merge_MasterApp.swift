import SwiftUI
import AVKit

@main
struct Merge_MasterApp: App {

    @StateObject var userViewModel = UserViewModel()
    @StateObject var shopViewModel = ShopViewModel()
    @StateObject var musicViewModel = MusicViewModel()
    @AppStorage("playSound") var playSound = true
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @State var audioPlayer: AVAudioPlayer!

    
    var body: some Scene {
        WindowGroup {
            Group{
                if isLoggedIn{
                    HomeView()
                        .environmentObject(userViewModel)
                        .environmentObject(shopViewModel)
                        .environmentObject(musicViewModel)
                }
                else{
                    AddUsernameView()
                        .environmentObject(userViewModel)
                        .environmentObject(shopViewModel)
                        .environmentObject(musicViewModel)
                }
            }
            .onAppear(){
                musicViewModel.playSounds("Music", true, -1, "wav")
            }
        }
    }
    
    
}
