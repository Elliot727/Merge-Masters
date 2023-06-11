import Foundation

struct GameModel:Identifiable, Hashable{
    var id = UUID()
    var tiles:[[TileModel?]]
    var time:Int
    var score:Int
}
