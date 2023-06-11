import Foundation

struct ShopItemModel:Identifiable, Hashable{
    var id = UUID()
    var powerUp:PowerUpTile
    var name:String
    var desc:String
    var coins:Int
}
