//
//  ContentView.swift
//  WalletAppAnimation
//
//  Created by netset on 28/02/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var colorGrid: [ColorGrid ] =
        [
            ColorGrid(color: Color("Orange"), hexValue: "FF8C00"),
            ColorGrid(color: Color("Green"), hexValue: "008000"),
            ColorGrid(color: Color("Blue"), hexValue: "0000FF"),
            ColorGrid(color: Color("Cyan"), hexValue: "00FFFF"),
            ColorGrid(color: Color("Voilet"), hexValue: "EE82EE"),
            ColorGrid(color: Color("Black"), hexValue: "D2691E"),
            ColorGrid(color: Color("Choclate"), hexValue: "D2691E")
        ]
    
    //MARK: Animation Properties Araray to keep track
    @State var animations: [Bool] = Array(repeating: false, count: 10)
    //MARK:
    @Namespace var animation
    @State private var cardColor = Color("Pink")
    var body: some View {
        VStack {
            HStack {
                Button {
                    //
                } label: {
                    Image(systemName: "arrow.left")
                }
                .hLeading()
                .foregroundColor(.white)
                
                Button {
                    //
                } label: {
                    Image("akshya")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                }
                .foregroundColor(.white)

            }.padding([.horizontal, .top])
                .padding(.bottom, 5)
            GeometryReader { proxy in
                let maxY = proxy.frame(in: .global).maxY
                creditCardView()
                    .rotation3DEffect(.degrees(animations[0] ? 0: -270), axis: (x: 1, y: 0, z: 0), anchor: .center)
                    .offset(y: animations[0] ? 0: -maxY)
            }.frame(height: 250)
            
            HStack {
                Text("Choose color")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .hLeading()
                    .offset(x: animations[1] ? 0: -200)
                Button {
                    for index in colorGrid.indices {
                        colorGrid[index].addToGrid = false
                        colorGrid[index].rotateCards = false
                        colorGrid[index].removeFromView = false
                        colorGrid[index].showText = false
                    }
                    animations = Array(repeating: false, count: 10)
                    animate()
                } label: {
                    Text("View all")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Pink"))
                        .underline()
                }
                .offset(x: animations[1] ? 0: 200)
            }
            .padding()
            
            GeometryReader { proxy in
            ZStack {
                    Color.black
                        .clipShape(CustomPath(radius: 40, corners: [.topLeft, .topRight]))
                        .padding(.top)
                        .frame(height: animations[2] ? nil: 0)
                    .vBottom()
                    
                    ZStack {
                        ForEach(colorGrid) { colorGrid in
                            if !colorGrid.removeFromView {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(colorGrid.color)
                                    .frame(width: 150, height: animations[3] ? 60: 150)
                                    //RotateCard
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 0.1)
                                            .frame(width: 150, height: animations[3] ? 60: 150)
                                            .shadow(color: .white.opacity(0.6), radius: 4, x: 0, y: 0)
                                        
                                    }
                                    .matchedGeometryEffect(id: colorGrid.id, in: animation)
                                    .rotationEffect(.degrees(colorGrid.rotateCards ? 180: 0))
                            }
                        }
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("BG"))
                            .frame(width: 150, height: animations[3] ? 60: 150)
                            .opacity(animations[3] ? 0: 1)
                    }
                    .scaleEffect(animations[3] ? 1: 2.3)
                }
                .hCenter()
                .vCenter()
                
                ScrollView(.vertical, showsIndicators: false) {
                    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(colorGrid) { colorGrid in
                            gridCardView(colorGrid: colorGrid)
                        }
                    }
                    .padding(.top, 40)
                }.padding()
                
            }.padding(.top)
        }
        .vTop()
        .hCenter()
        .background(Color("BG"))
        .ignoresSafeArea(.container, edges: .bottom)
        .onAppear(perform: animate)
    }
    
    func gridCardView(colorGrid: ColorGrid) -> some View {
        VStack {
            if colorGrid.addToGrid {
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorGrid.color)
                    .frame(width: 150, height: 60)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 0.1)
                            .frame(width: 150, height: animations[3] ? 60: 150)
                            .shadow(color: .white.opacity(0.6), radius: 4, x: 0, y: 0)
                        
                    }
                    .matchedGeometryEffect(id: colorGrid.id, in: animation)
                    .onAppear {
                        if let index = self.colorGrid.firstIndex(where: { color in
                            return color.id == colorGrid.id
                        }) {
                            withAnimation {
                                self.colorGrid[index].showText = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.11) {
                                withAnimation {
                                    self.colorGrid[index].removeFromView = true
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        cardColor = colorGrid.color
                    }
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.clear)
                    .frame(width: 150, height: 60)
            }
            
            Text(colorGrid.hexValue)
                .font(.caption)
                .fontWeight(.light)
                .hLeading()
                .padding(.horizontal, 30)
                .opacity(colorGrid.showText ? 1: 0)
        }
    }
   
    func creditCardView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(cardColor)
            VStack {
                HStack {
                    ForEach(0..<7) { index in
                        Circle()
                            .fill()
                            .frame(width: 6, height: 6)
                    }
                    Text("6786")
                        .font(.callout)
                        .fontWeight(.semibold)
                }.hLeading()
                
                HStack(spacing: -15) {
                    Text("Pratap Rana")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .hLeading()
                    
                    Circle()
                        .stroke(lineWidth: 2)
                        .frame(width: 30, height: 30)
                    Circle()
                        .stroke(lineWidth: 2)
                        .frame(width: 30, height: 30)
                }
                .vBottom()
            }
            .padding()
            .vTop()
            .hLeading()
            
            Circle()
                .stroke(lineWidth: 18)
                .opacity(1)
                .offset(x: 130, y: -120)
                .clipped()
        }
        .padding()
        .clipped()
    }
    
    func animate() {
        //MARK: Animations
        //First animation of card coming from upside of screen
        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.7, blendDuration: 0.7).delay(0.3)) {
            animations[0] = true
        }
        
        //second HStack Animation
        withAnimation(.easeInOut(duration: 0.5)) {
            animations[1] = true
        }
        
        //Making bottom card coming upside
        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.7, blendDuration: 0.7).delay(0.3)) {
            animations[2] = true
        }
        
        //making Animation for grid items
        withAnimation(.easeInOut(duration: 0.7)) {
            animations[3] = true
        }
        
        //Final Grid forming animation after opacity has finished
        //Rotate the card one after other after some delay

        for index in colorGrid.indices {
            let delay = 0.9 + (Double(index) * 0.1)
            let backIndex = ((colorGrid.count - 1) - index)
            withAnimation(.easeInOut.delay(delay)) {
                colorGrid[backIndex].rotateCards = true
            }
        
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation {
                    colorGrid[backIndex].addToGrid = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}


extension View {
    func hLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    func hTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    func hCenter() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
    func vCenter() -> some View {
        self.frame(maxHeight: .infinity, alignment: .center)
    }
    func vTop() -> some View {
        self.frame(maxHeight: .infinity, alignment: .top)
    }
    func vBottom() -> some View {
        self.frame(maxHeight: .infinity, alignment: .bottom)
    }
}
