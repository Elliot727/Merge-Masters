import SwiftUI
import AVKit

class MusicViewModel:ObservableObject{
    var audioPlayers: [AVAudioPlayer] = []



    func playSounds(_ soundFileName : String, _ playSound:Bool, _ loops:Int, _ ending:String) {
        
        if playSound{
            guard let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: ending) else {
                fatalError("Unable to find \(soundFileName) in bundle")
            }
            
            do {
                var audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer.numberOfLoops = loops
                audioPlayers.append(audioPlayer)
                audioPlayer.play()
            } catch {
                print("Error initializing audio player: \(error.localizedDescription)")
            }
            
        }
    }
    
}


