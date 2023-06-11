import SwiftUI

struct SelectGridSizeView: View {
    @State var gridSize: Int = 4
    let minSize: Int = 2
    let maxSize: Int = 4
    @State var isPresented:Bool = false
    @State var isPresented1:Bool = false
    @State var isPresented2:Bool = false
    @State var isPowerUps:Bool = false
    @State var useStillBlokcs:Bool = false
    @State var showAlert:Bool = false
    @State var nav:Bool = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var musicViewModel:MusicViewModel
    @EnvironmentObject var userViewModel:UserViewModel
    var body: some View {
        VStack(spacing:20){
            HStack{
                Button {
                    musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color("fgColor"))
                }
                Spacer()
            }
            Spacer()
            Text("Grid Size: \(gridSize)")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(Color("fgColor"))
            Button {
                musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                isPresented.toggle()
            } label: {
                Text("Change grid size")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color("fgColor"))
            }
            .fullScreenCover(isPresented: $isPresented) {
                gridPickerView
            }
            Button {
                musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                isPresented1.toggle()
            } label: {
                Text(isPowerUps ? "Powers Enabled":"Powers Disabled")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color("fgColor"))
            }
            .fullScreenCover(isPresented: $isPresented1) {
                powerUpPickerView
            }
            Button {
                musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                isPresented2.toggle()
            } label: {
                Text(useStillBlokcs ? "Hard Mode":"Easy Mode")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color("fgColor"))
            }
            .fullScreenCover(isPresented: $isPresented2) {
                modePickerView
            }
            
            Button {
                musicViewModel.playSounds("ButtonSound2", true, 0, "mp3")
                if isPowerUps && userViewModel.user.powerups.count < 1 {
                    isPowerUps = false
                    showAlert.toggle()
                }
                else{
                    nav.toggle()
                }
            } label: {
                Text("Start")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color("4096Color"))
            }
            .alert("You don't have any powerups yet so you can't use them", isPresented: $showAlert) {
                
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BG"))
        .navigationDestination(isPresented: $nav) {
            GameView(isPowerUps: isPowerUps, useStillBlocks: useStillBlokcs, gridSize: $gridSize)
                .navigationBarBackButtonHidden()
        }
    }

    
    var gridPickerView:some View{
        VStack{
            HStack{
                Button {
                    musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                    isPresented.toggle()
                } label: {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color("fgColor"))
                }
                Spacer()
            }
            Spacer()
            Text("Select a grid size")
                .padding()
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(Color("fgColor"))
            ForEach(minSize...maxSize, id: \.self){size in
                Button {
                    musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                    gridSize = size
                    isPresented.toggle()
                } label: {
                    Text("\(size)")
                        .padding()
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color("fgColor"))
                }
                
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BG"))
    }
    
    var powerUpPickerView:some View{
        VStack{
            HStack{
                Button {
                    musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                    isPresented1.toggle()
                } label: {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color("fgColor"))
                }
                Spacer()
            }
            Spacer()
            Text(isPowerUps ? "Powers Enabled":"Powers Disabled")
                .padding()
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(Color("fgColor"))

            Button {
                musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                isPowerUps.toggle()
                isPresented1.toggle()
            } label: {
                Text(isPowerUps ? "Disable Powers":"Enable Powers")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color("fgColor"))
            }
            Spacer()

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BG"))
    }
    
    var modePickerView:some View{
        VStack{
            HStack{
                Button {
                    musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                    isPresented2.toggle()
                } label: {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color("fgColor"))
                }
                Spacer()
            }
            Spacer()
            VStack(spacing: 20) {
                Button {
                    musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                    useStillBlokcs = false
                    isPresented2.toggle()
                } label: {
                    Text("Easy Mode")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color("fgColor"))
                }

                Button {
                    musicViewModel.playSounds("ButtonSound", true, 0, "mp3")
                    useStillBlokcs = true
                    isPresented2.toggle()
                } label: {
                    Text("Hard Mode")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color("fgColor"))
                }
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BG"))
    }
    
}

struct SelectGridSizeView_Previews: PreviewProvider {
    static let vm = MusicViewModel()
    static let vm1 = UserViewModel()
    static var previews: some View {
        SelectGridSizeView()
            .environmentObject(vm)
            .environmentObject(vm1)
    }
}
