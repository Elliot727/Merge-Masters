import Foundation

class ShopViewModel:ObservableObject{
    @Published var items:[ShopItemModel] = [ShopItemModel(powerUp: PowerUpTile(type: .multiplier), name: "Multiplier", desc: "Multiplies your score by 2 for 5 seconds", coins: 10), ShopItemModel(powerUp: PowerUpTile(type: .shuffleBoard), name: "Shuffle", desc: "Shuffles the board", coins: 5), ShopItemModel(powerUp: PowerUpTile(type: .swap), name: "Swap", desc: "", coins: 55), ShopItemModel(powerUp: PowerUpTile(type: .bomb), name: "Bomb", desc: "Removes a tile from the board", coins: 125), ShopItemModel(powerUp: PowerUpTile(type: .wildCard), name: "WildCard", desc: "Randomly changes a tiles value", coins: 500), ShopItemModel(powerUp: PowerUpTile(type: .spawn), name: "Portals", desc: "Opens a portal to another dimension allwoing a tile to spawn", coins: 1500)]
}
