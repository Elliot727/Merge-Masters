import SwiftUI

struct TileModel: Identifiable, Hashable {
    let id = UUID()
    var value: Int
    var fgColor: Color{
        switch value{
        case 2, 4:
            return Color("fgColor")
        default:
            return Color.white
        }

    }
    var type:TileType
    
    var color: Color {
        switch value {
        case 0:
            switch(type){
            case.normal:
                return Color("2Color")
            case.tree:
                return Color("Forest")
            case.lava:
                return Color("Lava")
            case.water:
                return Color("Ocean")
            case.portal:
                return Color("Teleport")
            }
        case 2:
            return Color("2Color")
        case 4:
            return Color("2Color")
        case 8:
            return Color("8Color")
        case 16:
            return Color("16Color")
        case 32:
            return Color("32Color")
        case 64:
            return Color("64Color")
        case 128:
            return Color("128Color")
        case 256:
            return Color("256Color")
        case 512:
            return Color("512Color")
        case 1024:
            return Color("1024Color")
        case 2048:
            return Color("2048Color")
        case 4069:
            return Color("4096Color")
        default:
            return Color.gray
        }
    }
}

enum TileType:String {
    case normal = "normal"
    case lava = "lava"
    case water = "water"
    case tree = "tree"
    case portal = "portal"
}
