import Foundation

struct UserModel:Identifiable{
    var id = UUID()
    var username:String
    var powerups:[PowerUpTile]
    var coins:Int
    var games:[GameModel]
}
