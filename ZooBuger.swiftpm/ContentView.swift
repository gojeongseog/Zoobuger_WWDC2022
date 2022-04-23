import SwiftUI
import SceneKit

struct ContentView: View {
    var body: some View {
        Oder()
    }
}


// Home View...

struct Home: View {
    
    var body: some View {
        VStack {
            Text("ZooBuger! 제목모델링")
            
            Button(action: {
                // to OderView
                
            }, label: {
                Text("PlAY")
                    .font(.title)
                    .bold()
            })
        }
    }
}

// Oder View

struct Oder: View {
    
    @State var models = [
        Model(id: 0, name: "chick", modelName: "chick_normar.usdz"),
        Model(id: 0, name: "chick", modelName: "dog_normar.usdz"),
        Model(id: 0, name: "chick", modelName: "lion_normar.usdz")
    ]
    
    @State var index = 0
    
    var body: some View {
        
        VStack {
            
            Text("\(index + 1)ROUND")
                .font(.title)
                .bold()
                .padding(.top, 50)
            
            ZStack {
                
                Image("bubble")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                Text("이런 이런 햄버거 먹고 싶어!")
                
            }
            .padding(120)
            
            Spacer(minLength: 0)
            
            SceneView(scene: SCNScene(named: models[index].modelName),options: [.autoenablesDefaultLighting,.allowsCameraControl])
            
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
            
            Button(action: {
                
            }, label: {
                Text("MAKE")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 50)
                
            })
            
        }
    }
}

// ResultView...


// Data Midels...

struct Model: Identifiable {
    
    var id: Int
    var name: String
    var modelName: String
}
