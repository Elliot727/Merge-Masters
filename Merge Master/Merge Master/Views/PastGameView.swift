//import SwiftUI
//
//struct PastGameView: View {
//    var game:Game
//    var body: some View {
//        VStack{
//            VStack(spacing: 10) {
//                ForEach(0..<game.tiles.count, id: \.self) { row in
//                    HStack {
//                        ForEach(0..<game.tiles[row].count, id: \.self) { col in
//                            if let tile = game.tiles[row][col] {
//                                TileView(tile: tile, tileSize: tileSize())
//                            } else {
//                                EmptyTileView(tileSize: tileSize())
//                            }
//                        }
//                    }
//                }
//            }
//            .padding()
//            .background(Color("bgGridColor"))
//            .cornerRadius(12)
//            HStack{
//                Text("\(game.score)")
//                Spacer()
//                Image(systemName: "clock")
//                Text("\((game.time  % 3600) / 60) mins")
//            }
//        }
//    }
//
//    func tileSize() -> CGFloat {
//        let screenWidth = UIScreen.main.bounds.width
//        let padding: CGFloat = 20 // Adjust the padding as needed
//        let tileSize = (screenWidth - padding) / CGFloat(gridSize)
//        let maximumTileSize = screenWidth / CGFloat(gridSize + 1)
//        return min(tileSize, maximumTileSize)
//    }
//
//}
//
//struct PastGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        PastGameView()
//    }
//}
