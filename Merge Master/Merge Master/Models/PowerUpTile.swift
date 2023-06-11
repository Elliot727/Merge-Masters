import Foundation

struct PowerUpTile:Identifiable, Hashable {
    let id = UUID()
    let type: PowerUpType
    var image:String{
        switch(type){
        case.shuffleBoard:
            return "Shuffle"
        case.multiplier:
            return "Bolt"
        case.swap:
            return "Swap"
        case.bomb:
            return "Bomb"
        case.wildCard:
            return "WildCard"
        case.spawn:
            return "Portal"
        }
    }
}

enum PowerUpType {
    case shuffleBoard
    case multiplier
    case swap
    case bomb
    case wildCard
    case spawn
}
