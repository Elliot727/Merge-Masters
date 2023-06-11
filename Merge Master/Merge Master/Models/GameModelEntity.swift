import Foundation
import CoreData

final class GameModelEntity:NSManagedObject{
    @NSManaged var tiles:TileModelEntity
    @NSManaged var score:Int64
    @NSManaged var time:Int64
}
