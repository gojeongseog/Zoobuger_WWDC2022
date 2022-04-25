import SwiftUI
import SceneKit

struct ContentView: View {
    
    @State var coin: Int = 0
    
    var body: some View {
        ZStack {
            
            NavigationView {
                
                VStack {
                    Text("ZooBuger! 제목모델링")
                    
                    NavigationLink(
                        destination: Oder(coin: self.$coin),
                        label: {
                            Text("PLAY")
                                .font(.title)
                                .bold()
                        }
                    )
                }
            }
            .navigationViewStyle(.stack)
            .navigationBarBackButtonHidden(true)
            
            VStack {
                HStack {
                    Spacer()
                    Text("COIN: \(coin)")
                        .foregroundColor(.yellow)
                        .font(.title)
                        .bold()
                }
                Spacer()
            }
        }
        
    }
}

// Oder View

struct Oder: View {
    
    

    @State var guestModels = [
        GuestModl(id: 0, name: "chick", modelName: "chick_normar.usdz",  coinScore: 50),
        GuestModl(id: 0, name: "chick", modelName: "dog_normar.usdz",  coinScore: 50),
        GuestModl(id: 0, name: "chick", modelName: "lion_normar.usdz",  coinScore: 50)
    ]
    
    
    @State var index = 0
    
    @Binding var coin: Int
    
    
    var body: some View {
        
        
        
        NavigationView {
            VStack {
                
                HStack {
                    Text("\(index + 1)ROUND")
                        .font(.title)
                        .bold()
                        .padding(.top, 50)

                }
                
                
                
                ZStack {
                    
                    Image("bubble")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    
                    Text("이런 이런 햄버거 먹고 싶어!")
                    
                }
                .padding(120)
                
                Spacer(minLength: 0)
                
                SceneView(scene: SCNScene(named: guestModels[index].modelName),options: [.autoenablesDefaultLighting,.allowsCameraControl])
                
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                
                NavigationLink(destination: Make(), label: {
                    Text("MAKE")
                        .font(.title)
                        .bold()
                        .padding(.bottom, 300)
                })
                
            }
            
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
        
    }
    
    
}


// ResultView...

// make View...



struct Make: View {
    
    @GestureState var isLongPressed = false
    
    @GestureState var locationState = CGPoint(x: UIScreen.main.bounds.width / 10,
                                              y: UIScreen.main.bounds.height / 2)
    @State var location = CGPoint(x: 100, y: UIScreen.main.bounds.height)
    
    
    
    
    @State var patty: Int = 0
    @State var lettuce: Int = 0
    @State var tomato: Int = 0
    @State var cheese: Int = 0
    @State var sweetsauce: Int = 0
    @State var hotsauce: Int = 0
    
    @State var index = 0
    
    
    
    @State var ingredientModels = [
        
        Ingredient(id: 1, name: "PATTY", textColor: .brown, modelName: "patty_normar.usdz" ),
        Ingredient(id: 1, name: "LETTUCE", textColor: .green,modelName: "lettuce_normar.usdz"),
        Ingredient(id: 1, name: "TOMATO", textColor: .red, modelName: "tomato__normar.usdz"),
        Ingredient(id: 1, name: "CHEESE", textColor: .yellow, modelName: "cheese_normar.usdz"),
        Ingredient(id: 1, name: "SAUCE", textColor: .red , modelName: "sauce")
        
        
    ]
    
    
    
    
    var body: some View {
        
        let longPressGesture = LongPressGesture()
            .updating($isLongPressed) { newValue, state, transaction in
                state = newValue
                
            }
        
        
        NavigationView {
            ZStack {
                
                SceneView(scene: SCNScene(named: ingredientModels[index].modelName),options: [.autoenablesDefaultLighting,.allowsCameraControl])
                
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
                HStack {
                    VStack {

                        
                        Text("PATTY: \(patty)")
                            .font(.title)
                            .bold()
                        Text("LETTUCE: \(lettuce)")
                            .font(.title)
                            .bold()
                        Text("TOMATO: \(tomato)")
                            .font(.title)
                            .bold()
                        Text("CHEESE: \(cheese)")
                            .font(.title)
                            .bold()
                        Text("SWEETSAUCE: \(sweetsauce)")
                            .font(.title)
                            .bold()
                        Text("HOTSAUCE: \(hotsauce)")
                            .font(.title)
                            .bold()
                        Spacer()
                        
                        Circle()
                            .frame(width: 150, height: 150, alignment: .center)
                            .foregroundColor(isLongPressed ? Color.orange : Color.blue)
                            .scaleEffect(isLongPressed ? 2 : 1)
                            .gesture(longPressGesture)
//                            .animation(.spring())
                        
                    }
                    .padding(30)
                    .ignoresSafeArea()
                    Spacer()
                    
                    
                }
                    
                
                
                // left to right
                Rectangle()
                    .fill(.gray.opacity(0.01))
                    .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height)
                    .position(locationState)
                    .gesture(
                        DragGesture()
                            .updating(
                            $locationState
                            ) { currnetState, pastLoction, transaction in
                                pastLoction = currnetState.location
                            }
                            
                            .onEnded { state in
                                location = state.location
                                if location.x > UIScreen.main.bounds.width / 2 && index > 0 && index < ingredientModels.count - 1 {
                                    
                                    if index == 1 {
                                        lettuce += 1
                                    } else if index == 2 {
                                        tomato += 1
                                    } else if index == 3 {
                                        cheese += 1
                                    }
                                }
                            }
                        
                    )
                
                // Forward and backward buttons...
                HStack {
                    Button(action: {
                        withAnimation {
                            if index > 0 {
                                index -= 1
                            }
                        }
                        
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 35, weight: .bold))
                    })
                    Spacer()
                    
                    VStack {
                        Spacer()
                        Text(ingredientModels[index].name)
                            .font(.system(size: 45, weight: .bold))
                            .padding(100)
                            .foregroundColor(ingredientModels[index].textColor)
                    }
                    Spacer()
                    Button(action: {
                        withAnimation {
                            if index < ingredientModels.count - 1 {
                                index += 1
                            }
                        }
                        
                    }, label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 35, weight: .bold))
                            .opacity(index == ingredientModels.count - 1 ? 0.3 : 1)
                    })
                    .disabled(index == ingredientModels.count - 1 ? true : false)
                }
                
                
                
                
                
                
                
                
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
        
        
    }
    
    
}




// Data Models(guest, ingredient)

struct GuestModl: Identifiable {
    
    var id: Int
    var name: String
    var modelName: String
    var coinScore: Int
}

struct Ingredient: Identifiable {
    
    var id: Int
    var name: String
    var textColor: Color
    var modelName: String
    
    
    
}
