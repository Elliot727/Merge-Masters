import Foundation
import CoreData
import UIKit

final class TileModelEntity:NSManagedObject{
    @NSManaged var color:UIColor
    @NSManaged var fgColor:UIColor
    @NSManaged var id:UUID
    @NSManaged var type:String
    @NSManaged var value:Int64
}
