import SwiftUI

struct GameView: View {
    @StateObject var vm = GameViewModel()
    @State var isPowerUps:Bool
    @State var useStillBlocks:Bool
    @State var nav:Bool = false
    @Binding var gridSize:Int
    @Environment(\.dismiss) var dismiss
    @AppStorage("playSound") var playSound = true
    @EnvironmentObject var musicViewModel:MusicViewModel
    @EnvironmentObject var userViewModel:UserViewModel
    var body: some View {
        ZStack {
            VStack{
                VStack {
                    HStack{
                        Button {
                            musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                            withAnimation(.easeIn){
                                vm.isTimePaused = true
                                vm.timer.upstream.connect().cancel()
                            }
                        } label: {
                            Text("Pause")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(Color("fgColor"))
                        }
                        .disabled(vm.isTimePaused)
                        Spacer()
                        if vm.isUsingMultiplier{
                            Text("\(vm.score)")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.red, .blue, .green, .yellow],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .animation(
                                    Animation.easeIn.repeatForever(autoreverses: true),
                                    value: 0
                                )
                        }
                        else{
                            Text("\(vm.score)")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(Color("fgColor"))
                        }
                        Spacer()
                        Button {
                            musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                            vm.reset(useStillBlocks)
                        } label: {
                            Text("Reset")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(Color("fgColor"))
                        }
                        .disabled(vm.isTimePaused)
                    }
                    .padding(.horizontal)
                    VStack(spacing:10) {
                        ForEach(0..<vm.tiles.count, id: \.self) { row in
                            HStack {
                                ForEach(0..<vm.tiles[row].count, id: \.self) { col in
                                    if let tile = vm.tiles[row][col] {
                                        TileView(tile: tile, tileSize: vm.tileSize())
                                            .onTapGesture {
                                                if vm.canUseBomb && !vm.canUseSwap && tile.type == .normal {
                                                    vm.canUseSwap = false
                                                    vm.tiles[row][col] = nil
                                                    vm.canUseBomb = false
                                                }
                                                
                                                if vm.canUseSwap && !vm.canUseBomb {
                                                    vm.canUseBomb = false
                                                    
                                                    if vm.selectedTiles.count < 2 {
                                                        vm.selectedTiles.append((row, col))
                                                    }
                                                    
                                                    if vm.selectedTiles.count == 2 {
                                                        vm.performSwap()
                                                    }
                                                }
                                            }

                                    } else {
                                        EmptyTileView(tileSize: vm.tileSize())
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color("bgGridColor"))
                    .cornerRadius(12)
                    .gesture(
                        DragGesture()
                            .onEnded({ value in
                                if !vm.isTimePaused{
                                    let horizontalSwipe = value.translation.width > 0 ? GameViewModel.SwipeDirection.right : GameViewModel.SwipeDirection.left
                                    let verticalSwipe = value.translation.height > 0 ? GameViewModel.SwipeDirection.down : GameViewModel.SwipeDirection.up
                                    
                                    if abs(value.translation.width) > abs(value.translation.height) {
                                        // Horizontal swipe
                                        vm.swipeTiles(direction: horizontalSwipe)
                                    } else {
                                        // Vertical swipe
                                        vm.swipeTiles(direction: verticalSwipe)
                                    }
                                }
                            })
                    )
                    HStack{
                        Spacer()
                        Text("\(vm.time)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color("fgColor"))
                    }
                    .padding()
                    if isPowerUps{
                        HStack {
                            ForEach(0..<gridSize) { index in
                                if index < vm.powers.count {
                                    Button {
                                        musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                                        vm.performPower(vm.powers[index])
                                        vm.powers.remove(at: index)
                                    } label: {
                                        PowerTileView(tileSize: vm.tileSize(), power: vm.powers[index])
                                    }
                                    
                                } else {
                                    EmptyTileView(tileSize: vm.tileSize())
                                }
                            }
                        }
                    }
                }
                
                .onReceive(vm.timer) { _ in
                    if vm.time % 9 == 0 {
                        vm.randomPowerUp()
                    }
                    vm.time+=1
                    if vm.isUsingMultiplier{
                        if vm.multiplierTime == 0{
                            vm.isUsingMultiplier = false
                            vm.multiplierTime = 5
                        }
                        else{
                            vm.multiplierTime -= 1
                        }
                    }
                }
            }
            .onAppear {
                vm.avaliablePowerUps = userViewModel.user.powerups
                vm.gridSize = gridSize
                vm.tiles = Array(repeating: Array(repeating: nil, count: gridSize), count: gridSize)
                withAnimation(.easeIn){
                    for _ in Range(0...1){
                        vm.spawnTile()
                        if useStillBlocks{
                            vm.spawnNewStillTile()
                        }
                    }
                }
            }
            .blur(radius: vm.isTimePaused ? 15:0)
            .blur(radius: vm.isGridFull() ? 15:0)
            if vm.isTimePaused{
                VStack(spacing:20){
                    Button {
                        musicViewModel.playSounds("ButtonSound2", true, 0, "mp3")
                        withAnimation(.easeIn){
                            vm.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                            vm.isTimePaused = false
                        }
                    } label: {
                        Text("Resume")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color("4096Color"))
                    }
                    Button {
                        musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                        dismiss()
                    } label: {
                        Text("Quit")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color("4096Color"))
                    }
                }
                
            }
            if vm.isGridFull(){
                VStack{
                    Text("\(vm.score)")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(Color("4096Color"))
                    Button {
                        let coins = Int((Double(vm.score) * 0.1).rounded())
                        userViewModel.user.coins += coins
                        nav.toggle()
                    } label: {
                        Text("Home")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color("4096Color"))
                    }
                    .onTapGesture {
                        musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                    }

                    
                }
            }
        }
        .navigationDestination(isPresented: $nav, destination: {
            HomeView()
                .navigationBarBackButtonHidden()
        })
        .frame(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color("BG"))
    }
    
}

struct TileView: View {
    var tile: TileModel
    let tileSize: CGFloat
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(tile.color)
                .frame(width: tileSize, height: tileSize)
            if tile.type == .normal{
                Text("\(tile.value)")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(tile.fgColor)
            }
        }
    }
}

struct EmptyTileView: View {
    let tileSize: CGFloat
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("emptyGridColor"))
            .frame(width: tileSize, height: tileSize)
    }
}

struct PowerTileView: View {
    let tileSize: CGFloat
    let power:PowerUpTile
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("emptyGridColor"))
                .frame(width: tileSize, height: tileSize)
            Image(power.image)
                .renderingMode(.template)
                .foregroundColor(Color("2Color"))
                .font(.system(size: 25, weight: .bold))
                .imageScale(.large)
                .frame(width: 50, height: 50)
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static let userVM = UserViewModel()
    static let vm = MusicViewModel()
    static var previews: some View {
        GameView(isPowerUps: true, useStillBlocks: true, gridSize: .constant(4))
            .environmentObject(vm)
            .environmentObject(userVM)
    }
}
