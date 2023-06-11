import Foundation

class UserViewModel:ObservableObject{
    @Published var user:UserModel = UserModel(username: "", powerups: [], coins: 5, games: [])
}
