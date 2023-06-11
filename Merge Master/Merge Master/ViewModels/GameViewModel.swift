import SwiftUI

class GameViewModel:ObservableObject{
    @Published var tiles: [[TileModel?]] = []
    @Published var selectedTiles: [(row: Int, col: Int)] = []
    @Published var score:Int = 0
    @Published var time:Int = 0
    @Published var multiplierTime:Int = 5
    @Published var isUsingMultiplier:Bool = false
    @Published var canUseBomb:Bool = false
    @Published var canUseSwap:Bool = false
    @Published var isTimePaused:Bool = false
    @Published var powers:[PowerUpTile] = []
    @Published var avaliablePowerUps:[PowerUpTile] = []
    @Published var gridSize:Int = 0
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    func shuffleBoard() {
        // Flatten the 2D tiles array into a 1D array
        var flattenedTiles = tiles.flatMap { $0 }
        
        // Perform Fisher-Yates shuffle
        for i in 0..<(flattenedTiles.count - 1) {
            let j = Int.random(in: i..<(flattenedTiles.count))
            flattenedTiles.swapAt(i, j)
        }
        
        // Update the tiles array with the shuffled tiles
        tiles = stride(from: 0, to: flattenedTiles.count, by: gridSize).map { index in
            Array(flattenedTiles[index..<index+gridSize])
        }
    }
    
    func performSwap() {
        
        let tile1 = tiles[selectedTiles[0].row][selectedTiles[0].col]
        let tile2 = tiles[selectedTiles[1].row][selectedTiles[1].col]
        
        let tempTile = tile1
        tiles[selectedTiles[0].row][selectedTiles[0].col] = tile2
        tiles[selectedTiles[1].row][selectedTiles[1].col] = tempTile
        
        selectedTiles = []
        canUseSwap = false
    }
    
    func randomPowerUp(){
        if avaliablePowerUps.isEmpty{
            
        }
        else{
            let randomIndex = Int.random(in: 0..<avaliablePowerUps.count)
            let selectedPowerUp = avaliablePowerUps[randomIndex]
            if powers.count == 4{
                return
            }
            else{
                powers.append(selectedPowerUp)
            }
        }
    }
    
    func performPower(_ power:PowerUpTile){
        switch(power.type){
        case.shuffleBoard:
            shuffleBoard()
        case.multiplier:
            if multiplierTime == 5{
                
            }
            else{
                multiplierTime += 5
            }
            isUsingMultiplier = true
        case.swap:
            canUseBomb = false
            canUseSwap = true
        case.bomb:
            canUseSwap = false
            canUseBomb = true
        case.wildCard:
            canUseSwap = false
            canUseBomb = false
            changeTileValue()
        case.spawn:
            canUseSwap = false
            canUseBomb = false
            spawnNewTile()
        }
    }
    
    func spawnNewStillTile(){
        let types: [TileType] = [.water, .lava, .tree, .portal]
        let tile = TileModel(value: 0, type: types.randomElement() ?? .tree)
        var emptyPositions = [(Int, Int)]()
        
        // Find all null positions
        for row in 0..<tiles.count {
            for col in 0..<tiles[row].count {
                if tiles[row][col] == nil {
                    emptyPositions.append((row, col))
                }
            }
        }
        
        // Choose a random empty position
        if let randomPosition = emptyPositions.randomElement() {
            let (row, col) = randomPosition
            
            // Create and assign a new tile to the null position
            tiles[row][col] = tile
            
        }
    }
    
    func spawnNewTile(){
        let values: [Int] = [2, 4, 8, 16]
        let tile = TileModel(value: values.randomElement() ?? 2, type: .normal)
        var emptyPositions = [(Int, Int)]()
        
        // Find all null positions
        for row in 0..<tiles.count {
            for col in 0..<tiles[row].count {
                if tiles[row][col] == nil {
                    emptyPositions.append((row, col))
                }
            }
        }
        
        // Choose a random empty position
        if let randomPosition = emptyPositions.randomElement() {
            let (row, col) = randomPosition
            
            // Create and assign a new tile to the null position
            tiles[row][col] = tile
        }
    }
    
    func changeTileValue() {
        let values: [Int] = [2, 4, 8, 16]
        let numRows = tiles.count
        let numCols = tiles[0].count
        
        // Generate random indices within the valid range
        let randomRow = Int.random(in: 0..<numRows)
        let randomCol = Int.random(in: 0..<numCols)
        
        // Access the randomly selected tile from the 2D array
        if let _ = tiles[randomRow][randomCol] {
            // Create a new tile with the updated value
            let updatedTile = TileModel(value: values.randomElement() ?? 2, type: .normal)
            // Replace the existing tile in the array with the new tile
            tiles[randomRow][randomCol] = updatedTile
        }
    }
    
    
    func reset(_ isHardMode:Bool){
        if isTimePaused{
            withAnimation(.easeIn){
                isTimePaused.toggle()
            }
        }
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        time = 0
        score = 0
        tiles = Array(repeating: Array(repeating: nil, count: gridSize), count: gridSize)
        multiplierTime = 5
        isUsingMultiplier = false
        canUseSwap = false
        canUseBomb = false
        powers = []
        spawnTile()
        spawnTile()
        if isHardMode{
            spawnNewStillTile()
            spawnNewStillTile()
        }
    }
    
    func findRandomEmptyTile(_ tiles: [[TileModel?]]) -> (row: Int, col: Int)? {
        var emptyTiles = [(row: Int, col: Int)]()
        
        // Find empty tiles
        for row in 0..<tiles.count {
            for col in 0..<tiles[row].count {
                if tiles[row][col] == nil {
                    emptyTiles.append((row: row, col: col))
                }
            }
        }
        
        // Check if there are empty tiles
        guard !emptyTiles.isEmpty else {
            return nil // Return nil if there are no empty tiles
        }
        
        // Select a random empty tile
        let randomIndex = Int.random(in: 0..<emptyTiles.count)
        let randomEmptyTile = emptyTiles[randomIndex]
        
        return randomEmptyTile
    }
    
    enum SwipeDirection {
        case up, down, left, right
    }
    
    @MainActor func swipeTiles(direction: SwipeDirection) {
        var madeMove = false

        switch direction {
        case .up:
            if !canSwipeUp(){
                return
            }
            else{
                for col in 0..<tiles[0].count {
                    var merged = false
                    
                    for row in 1..<tiles.count {
                        if let currentTile = tiles[row][col] {
                            if currentTile.type == .normal{
                                var targetRow = row
                                
                                // Move the tile as far up as possible
                                while targetRow > 0 && tiles[targetRow - 1][col] == nil {
                                    targetRow -= 1
                                }
                                
                                if targetRow != row {
                                    // Move the tile to the new position
                                    tiles[targetRow][col] = currentTile
                                    tiles[row][col] = nil
                                }
                                
                                if targetRow > 0 {
                                    // Merge tiles if their values are equal
                                    let aboveTile = tiles[targetRow - 1][col]
                                    var currentTile = currentTile
                                    if aboveTile?.type == .water{
                                        if currentTile.value == 2{
                                            
                                        }
                                        else{
                                            currentTile.value = currentTile.value / 2
                                            tiles[row][col] = currentTile
                                        }
                                    }
                                    if aboveTile?.type == .lava{
                                        tiles[row][col] = nil
                                    }
                                    if aboveTile?.type == .portal {
                                        if let randomEmptyTile = findRandomEmptyTile(tiles) {
                                            let row1 = randomEmptyTile.row
                                            let col1 = randomEmptyTile.col
                                            tiles[row][col] = nil
                                            tiles[row1][col1] = currentTile
                                        }
                                    }
                                    if !merged && aboveTile?.value == currentTile.value {
                                        tiles[targetRow - 1][col] = mergeTiles(aboveTile, currentTile)
                                        tiles[row][col] = nil
                                        merged = true
                                    }
                                }
                            }
                            else{
                                
                            }
                        }
                    }
                }
                madeMove = true
            }
        case .down:
            if !canSwipeDown(){
                return
            }
            else{
                for col in 0..<tiles[0].count {
                    var merged = false
                    
                    for row in (0..<tiles.count - 1).reversed() {
                        if let currentTile = tiles[row][col] {
                            if currentTile.type == .normal{
                                var targetRow = row
                                
                                // Move the tile as far down as possible
                                while targetRow < tiles.count - 1 && tiles[targetRow + 1][col] == nil {
                                    targetRow += 1
                                }
                                
                                if targetRow != row {
                                    // Move the tile to the new position
                                    tiles[targetRow][col] = currentTile
                                    tiles[row][col] = nil
                                }
                                
                                if targetRow < tiles.count - 1 {
                                    // Merge tiles if their values are equal
                                    let belowTile = tiles[targetRow + 1][col]
                                    var currentTile = currentTile
                                    if belowTile?.type == .water{
                                        if currentTile.value == 2{
                                            
                                        }
                                        else{
                                            currentTile.value = currentTile.value / 2
                                            tiles[row][col] = currentTile
                                        }
                                    }
                                    if belowTile?.type == .lava{
                                        tiles[row][col] = nil
                                    }
                                    if belowTile?.type == .portal {
                                        if let randomEmptyTile = findRandomEmptyTile(tiles) {
                                            let row1 = randomEmptyTile.row
                                            let col1 = randomEmptyTile.col
                                            tiles[row][col] = nil
                                            tiles[row1][col1] = currentTile
                                        }
                                    }
                                    if !merged && belowTile?.value == currentTile.value {
                                        tiles[targetRow + 1][col] = mergeTiles(belowTile, currentTile)
                                        tiles[row][col] = nil
                                        merged = true
                                    }
                                }
                            }
                            else{
                                
                            }
                        }
                    }
                }
                madeMove = true
            }
        case .left:
            if !canSwipeLeft(){
                return
            }
            else{
                for row in 0..<tiles.count {
                    var merged = false
                    
                    for col in 1..<tiles[row].count {
                        if let currentTile = tiles[row][col] {
                            if currentTile.type == .normal{
                                var targetCol = col
                                
                                // Move the tile as far left as possible
                                while targetCol > 0 && tiles[row][targetCol - 1] == nil {
                                    targetCol -= 1
                                }
                                
                                if targetCol != col {
                                    // Move the tile to the new position
                                    tiles[row][targetCol] = currentTile
                                    tiles[row][col] = nil
                                }
                                
                                if targetCol > 0 {
                                    // Merge tiles if their values are equal
                                    let leftTile = tiles[row][targetCol - 1]
                                    var currentTile = currentTile
                                    if leftTile?.type == .water{
                                        if currentTile.value == 2{
                                            
                                        }
                                        else{
                                            currentTile.value = currentTile.value / 2
                                            tiles[row][col] = currentTile
                                        }
                                    }
                                    if leftTile?.type == .lava{
                                        tiles[row][col] = nil
                                    }
                                    if leftTile?.type == .portal {
                                        if let randomEmptyTile = findRandomEmptyTile(tiles) {
                                            let row1 = randomEmptyTile.row
                                            let col1 = randomEmptyTile.col
                                            tiles[row][col] = nil
                                            tiles[row1][col1] = currentTile
                                        }
                                    }
                                    if !merged && leftTile?.value == currentTile.value {
                                        tiles[row][targetCol - 1] = mergeTiles(leftTile, currentTile)
                                        tiles[row][col] = nil
                                        merged = true
                                    }
                                }
                            }
                            else{
                                
                            }
                        }
                    }
                }
                madeMove = true
            }
        case .right:
            if !canSwipeRight(){
                return
            }
            else{
                for row in 0..<tiles.count {
                    var merged = false
                    
                    for col in (0..<tiles[row].count - 1).reversed() {
                        if let currentTile = tiles[row][col] {
                            if currentTile.type == .normal{
                                var targetCol = col
                                
                                // Move the tile as far right as possible
                                while targetCol < tiles[row].count - 1 && tiles[row][targetCol + 1] == nil {
                                    targetCol += 1
                                }
                                
                                if targetCol != col {
                                    // Move the tile to the new position
                                    tiles[row][targetCol] = currentTile
                                    tiles[row][col] = nil
                                }
                                
                                if targetCol < tiles[row].count - 1 {
                                    // Merge tiles if their values are equal
                                    let rightTile = tiles[row][targetCol + 1]
                                    var currentTile = currentTile
                                    if rightTile?.type == .water{
                                        if currentTile.value == 2{
                                            
                                        }
                                        else{
                                            currentTile.value = currentTile.value / 2
                                            tiles[row][col] = currentTile
                                        }
                                    }
                                    if rightTile?.type == .lava{
                                        tiles[row][col] = nil
                                    }
                                    if rightTile?.type == .portal {
                                        if let randomEmptyTile = findRandomEmptyTile(tiles) {
                                            let row1 = randomEmptyTile.row
                                            let col1 = randomEmptyTile.col
                                            tiles[row][col] = nil
                                            tiles[row1][col1] = currentTile
                                        }
                                    }
                                    if !merged && rightTile?.value == currentTile.value {
                                        tiles[row][targetCol + 1] = mergeTiles(rightTile, currentTile)
                                        tiles[row][col] = nil
                                        merged = true
                                    }
                                }
                            }
                            else{
                                
                            }
                        }
                    }
                }
                madeMove = true
            }
            
        }
        
        if madeMove {
            if isGridFull(){
                timer.upstream.connect().cancel()
                print("Grid is full")
                var game = GameModel(tiles: tiles, time: time, score: score)
            }
            else{
                spawnTile()
            }
        }
    }
    
    func mergeTiles(_ tile1: TileModel?, _ tile2: TileModel) -> TileModel {
        var mergedTile = tile2
        mergedTile.value *= 2
        calcScore(mergedTile)
        return mergedTile
    }
    
    
    func spawnTile() {
        var emptyPositions = [(Int, Int)]()
        
        // Find all null positions
        for row in 0..<tiles.count {
            for col in 0..<tiles[row].count {
                if tiles[row][col] == nil {
                    emptyPositions.append((row, col))
                }
            }
        }
        
        // Choose a random empty position
        if let randomPosition = emptyPositions.randomElement() {
            let (row, col) = randomPosition
            
            // Create and assign a new tile to the null position
            tiles[row][col] = randomTile()
        }
    }
    
    func randomTile() -> TileModel {
        let randomNumber = Int.random(in: 1...10)
        
        if randomNumber == 1 {
            return TileModel(value: 4, type: .normal)
        } else {
            return TileModel(value: 2, type: .normal)
        }
    }
    
    
    func canSwipeUp() -> Bool {
        for col in 0..<tiles[0].count {
            for row in 1..<tiles.count {
                if let currentTile = tiles[row][col], tiles[row - 1][col] == nil || tiles[row - 1][col]?.value == currentTile.value {
                    return true
                }
            }
        }
        return false
    }
    
    func canSwipeDown() -> Bool {
        for col in 0..<tiles[0].count {
            for row in (0..<tiles.count - 1).reversed() {
                if let currentTile = tiles[row][col], tiles[row + 1][col] == nil || tiles[row + 1][col]?.value == currentTile.value {
                    return true
                }
            }
        }
        return false
    }
    
    func canSwipeLeft() -> Bool {
        for row in 0..<tiles.count {
            for col in 1..<tiles[row].count {
                if let currentTile = tiles[row][col], tiles[row][col - 1] == nil || tiles[row][col - 1]?.value == currentTile.value {
                    return true
                }
            }
        }
        return false
    }
    
    func canSwipeRight() -> Bool {
        for row in 0..<tiles.count {
            for col in (0..<tiles[row].count - 1).reversed() {
                if let currentTile = tiles[row][col], tiles[row][col + 1] == nil || tiles[row][col + 1]?.value == currentTile.value {
                    return true
                }
            }
        }
        return false
    }
    
    func isGridFull() -> Bool {
        for row in 0..<tiles.count {
            for col in 0..<tiles[row].count {
                if tiles[row][col] == nil {
                    return false
                }
            }
        }
        
//        if hasValidMoves() {
//            return false
//        }
        
        return true
    }

    
    
    func calcScore(_ tile:TileModel){
        if isUsingMultiplier{
            score+=(tile.value*2)
        }
        else{
            score+=tile.value
        }
    }
    
    func hasValidMoves() -> Bool {
        return canSwipeUp() || canSwipeDown() || canSwipeLeft() || canSwipeRight()
    }
    
    func tileSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let padding: CGFloat = 20 // Adjust the padding as needed
        let tileSize = (screenWidth - padding) / CGFloat(gridSize)
        let maximumTileSize = screenWidth / CGFloat(gridSize + 1)
        return min(tileSize, maximumTileSize)
    }
}
