//
//  CustomRefleshView.swift
//  UI-566
//
//  Created by nyannyan0328 on 2022/05/20.
//

import SwiftUI
import Lottie

struct CustomRefleshView<Content : View>: View {
    
    var content : Content
    var lottieName : String
    var showIndicator : Bool
    var onReflesh : ()async->()
    
    
    init(lottieName : String,showIndicator : Bool = false,@ViewBuilder content : @escaping()->Content,onReflesh : @escaping()async->()) {
        self.content = content()
        self.lottieName = lottieName
        self.showIndicator = showIndicator
        self.onReflesh = onReflesh
    }
    @StateObject var model : ScrollDelegate = .init()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing:0){
                
                LottteBoundsView(lottieFileName: lottieName, isPlaying: $model.isRefleshing)
                    .scaleEffect(model.isEllible ? 1 : 0.001)
                    .animation(.easeInOut(duration: 0.2), value: model.isEllible)
                    .overlay(content: {
                        
                        VStack(spacing:0){
                            
                            Image(systemName: "arrow.down")
                                .font(.caption.bold())
                                .foregroundColor(.white)
                                .rotationEffect(.init(degrees: model.progress * 360))
                                .padding(10)
                                .background(.primary,in: Circle())
                            
                            Text("Pull to Reflesh")
                                .font(.caption.bold())
                                .foregroundColor(.primary)
                            
                            
                            
                            
                        }
                        .opacity(model.isEllible ? 0 : 1)
                        .animation(.easeInOut(duration: 0.25), value: model.isEllible)
                    })
                  
                    .frame(height: 150 * model.progress)
                    .opacity(model.progress)
                    .offset(y: model.isEllible ? -(model.contentOffset < 0 ? 0 : model.contentOffset) : -(model.scrollOffset < 0 ? 0 : model.scrollOffset))
                
                
                
                content
                
                
                
            }
            .offset(coordinateSpace: "SCROLL") { offset in
                
                
                model.contentOffset = offset
                if !model.isEllible{
                    
                    
                    var progess = offset / 150
                    
                    progess = (progess < 0 ? 0 : progess)
                    progess = (progess > 1 ? 1 : progess)
                    
                    model.scrollOffset = offset
                    model.progress = progess
                }
                
                if model.isEllible && !model.isRefleshing{
                    
                    model.isRefleshing = true
                    
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }
                
                
                
            }
            
           
           
        }
        .coordinateSpace(name: "SCROLL")
        .onAppear(perform: model.addGesture)
        .onDisappear(perform: model.removeGesture)
        .onChange(of: model.isRefleshing) { newValue in
            
            if newValue{
                
                Task{
                    
                    await onReflesh()
                    
                    withAnimation(.easeInOut(duration: 0.25)){
                        
                        model.progress = 0
                        model.isEllible = false
                        model.isRefleshing = false
                        model.scrollOffset = 0
                        
                        
                    }
                }
            }
        }
    }
}



struct CustomRefleshView_Previews: PreviewProvider {
    static var previews: some View {
        
        CustomRefleshView(lottieName: "Loading") {
            
            Rectangle()
                .fill(.red)
                .frame(height: 300)
            
        } onReflesh: {
            
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            
            
        }

      

    }
}

class ScrollDelegate : NSObject,ObservableObject,UIGestureRecognizerDelegate{
    
    @Published var isEllible : Bool = false
    @Published var isRefleshing : Bool = false
    
    @Published var scrollOffset : CGFloat = 0
    @Published var contentOffset : CGFloat = 0
    
    @Published var progress : CGFloat = 0
    
    
    
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    func addGesture(){
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onGestureChange(gesutrue:)))
        
        panGesture.delegate = self
        
        uiviewController().view.addGestureRecognizer(panGesture)
        
    }
    
    func removeGesture(){
        
        
        uiviewController().view.gestureRecognizers?.removeAll()
        
    }
    
    @objc
    func onGestureChange(gesutrue : UIPanGestureRecognizer){
        
        if gesutrue.state == .cancelled || gesutrue.state == .ended{
            
            
            if !isRefleshing{
                
                if scrollOffset > 150{
                    
                    isEllible = true
                }
                else{
                    
                    isEllible = false
                }
            }
            
        }
    }
    
    
    
}

extension View{
    
    @ViewBuilder
    func offset(coordinateSpace : String,offset : @escaping(CGFloat) ->()) -> some View{
        
        
        self
            .overlay {
                GeometryReader{proxy in
                    
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    
                    Color.clear
                        .preference(key: offsetKey.self, value: minY)
                        .onPreferenceChange(offsetKey.self) { value in
                            offset(value)
                        }
                    
                    
                }
            }
        
        
    }

    
    
}

func uiviewController()->UIViewController{
    
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{return .init()}
    
    guard let uiview = screen.windows.first?.rootViewController else{
        
        return .init()
    }
    
    return uiview
    }


struct LottteBoundsView : UIViewRepresentable{
    var lottieFileName : String
    @Binding var isPlaying : Bool
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        addToView(view: view)
        return view
        
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        
        
        uiView.subviews.forEach { view in
            if view.tag == 1009,let lottieView = view as? AnimationView{
                
                if isPlaying{
                    
                    lottieView.play()
                }
                else{
                    
                    lottieView.pause()
                }
            }
        }
        
        
        
    }
    
    func addToView(view to : UIView){
        
        let animationView = AnimationView(name: lottieFileName, bundle: .main)
        animationView.backgroundColor = .clear
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.tag = 1009
        
        let contains = [
        
            animationView.heightAnchor.constraint(equalTo: to.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: to.widthAnchor)
            
        
        ]
        
        to.addConstraints(contains)
        to.addSubview(animationView)
        
    }
}

struct offsetKey : PreferenceKey{
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        
        value = nextValue()
    }
}
