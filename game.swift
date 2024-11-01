//
//  game.swift
//  Stak Fantasy
//
//  Created by Admin on 20.10.2024.
//

import Foundation
import UIKit

public class game: UIViewController{
    let fruits: [Fruit] = [
           Fruit(name: "item1", color: .red),
           Fruit(name: "item2", color: .purple),
           Fruit(name: "item3", color: .blue),
           Fruit(name: "item4", color: .red),
           Fruit(name: "item5", color: .purple),
           Fruit(name: "item6", color: .red),
           Fruit(name: "item7", color: .red),
           Fruit(name: "item8", color: .yellow),
       ]
       
    var fruitImageViews: [UIImageView] = []
    var baskets: [Basket] = [
        Basket(name: "basket1", color: .purple),
        Basket(name: "basket2", color: .red),
        Basket(name: "basket3", color: .yellow),
        Basket(name: "basket4", color: .green),
        Basket(name: "basket5", color: .blue),
    ]
    
    var basketers: [Basket] = []
    var centerbasket: Basket!
    
    public var leveValue: Int = 0
    private let timerLabel = UILabel()
    private let levellabel = UILabel()
    
    private var gameTime: Timer!
    private var timerValue: CGFloat = 0
    
    private var isEnd: Bool = false

    public override func viewDidLoad() {
        super.viewDidLoad()
        isEnd = false
        for i in 0...leveValue + 1{
            timerValue += 3.1
        }
        bg()
        setupBaskets()
        setupFruits()
        ScoreLabel()
        levelLabel()
        startUpdate()
    }
    
    @objc private func update(){
           if isEnd == true{
               return
           }
           timerValue -= 0.01
           timerLabel.text = String(format:"LEFT TIME %.2fs",timerValue)
        if fruitImageViews.count <= 0{
            isEnd = true
            result(value: true)
        }
        
           if timerValue <= 0{
               isEnd = true
               result(value: false)
           }
       }
       func startUpdate() {
           gameTime = Timer.scheduledTimer(timeInterval:0.01, target: self, selector: #selector(update), userInfo: nil, repeats: true)
       }
    
    private func result(value: Bool){
        let vc = results()
        vc.navigationItem.hidesBackButton = true
        vc.modalPresentationStyle = .fullScreen
        vc.isWin = value
        self.present(vc, animated: true)
    }
    
    private func levelLabel(){
        
        levellabel.translatesAutoresizingMaskIntoConstraints = false
        levellabel.text = "LEVEL \(leveValue + 1)"
        levellabel.textAlignment = .center
        levellabel.textColor = .white
        levellabel.contentMode = .scaleAspectFit
        levellabel.minimumScaleFactor = 0.001
        levellabel.adjustsFontSizeToFitWidth = true
        levellabel.layer.zPosition = 2
        levellabel.font = UIFont(name: "Futura-Bold", size: 300)
        view.addSubview(levellabel)
        
        NSLayoutConstraint.activate([
            levellabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 90),
            levellabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -90),
            levellabel.topAnchor.constraint(equalTo: timerLabel.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            levellabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func ScoreLabel(){
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.text = "0"
        timerLabel.textAlignment = .center
        timerLabel.textColor = .white
        timerLabel.contentMode = .scaleAspectFit
        timerLabel.minimumScaleFactor = 0.001
        timerLabel.adjustsFontSizeToFitWidth = true
        timerLabel.layer.zPosition = 2
        timerLabel.font = UIFont(name: "Futura-Bold", size: 300)
        view.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            timerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 90),
            timerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -90),
            timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            timerLabel.heightAnchor.constraint(equalToConstant: 70),
        ])
    }

    private func bg(){
        let bg = UIImageView(image: UIImage(named: data.GetBGName()))
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.contentMode = .scaleToFill
        view.addSubview(bg)
        
        NSLayoutConstraint.activate([
            bg.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            bg.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            bg.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            bg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    func setupBaskets() {
        for i in 0...baskets.count - 1 {
            let basket = Basket(name: baskets[i].name ,color: baskets[i].color)
            basket.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(basket)
            
            if basketers.count <= 0 {
                centerbasket = basket
                NSLayoutConstraint.activate([
                    basket.widthAnchor.constraint(equalToConstant: 60),
                    basket.heightAnchor.constraint(equalToConstant: 60),
                    basket.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
                    basket.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
                ])
            }
            else if basketers.count > 0 && basketers.count < 3{
                if basketers.count == 1 {
                    NSLayoutConstraint.activate([
                        basket.widthAnchor.constraint(equalToConstant: 60),
                        basket.heightAnchor.constraint(equalToConstant: 60),
                        basket.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
                        basket.leftAnchor.constraint(equalTo: centerbasket.safeAreaLayoutGuide.leftAnchor, constant: -60),
                    ])
                }
                else{
                    NSLayoutConstraint.activate([
                        basket.widthAnchor.constraint(equalToConstant: 60),
                        basket.heightAnchor.constraint(equalToConstant: 60),
                        basket.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
                        basket.leftAnchor.constraint(equalTo: basketers[basketers.count - 1].safeAreaLayoutGuide.leftAnchor, constant: -60),
                    ])
                }
            }
            else if basketers.count >= 3{
                if basketers.count == 3 {
                    NSLayoutConstraint.activate([
                        basket.widthAnchor.constraint(equalToConstant: 60),
                        basket.heightAnchor.constraint(equalToConstant: 60),
                        basket.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
                        basket.rightAnchor.constraint(equalTo: centerbasket.safeAreaLayoutGuide.rightAnchor, constant: 60),
                    ])
                }
                else{
                    NSLayoutConstraint.activate([
                        basket.widthAnchor.constraint(equalToConstant: 60),
                        basket.heightAnchor.constraint(equalToConstant: 60),
                        basket.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
                        basket.rightAnchor.constraint(equalTo: basketers[basketers.count - 1].safeAreaLayoutGuide.rightAnchor, constant: 60),
                    ])
                }
            }

            basketers.append(basket)
        }
    }
    
    func setupFruits() {
        for i in 0...Int.random(in: 1...leveValue + 5){
            let fruitIndex = Int.random(in: 0...fruits.count - 1)
            let fruitImageView = UIImageView(image: UIImage(named: fruits[fruitIndex].name))
            fruitImageView.frame = CGRect(x: Int.random(in: 0..<Int(view.bounds.width - 50)),
                                          y: Int.random(in: 0..<Int(view.bounds.height / 2)),
                                          width: 50, height: 50)
            fruitImageView.isUserInteractionEnabled = true
            fruitImageView.tag = fruits[fruitIndex].color.rawValue // Присваиваем tag цвету фрукта
            view.addSubview(fruitImageView)
            fruitImageViews.append(fruitImageView)
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            fruitImageView.addGestureRecognizer(panGesture)
        }
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let fruitImageView = gesture.view as? UIImageView else { return }
        let translation = gesture.translation(in: view)
        fruitImageView.center = CGPoint(x: fruitImageView.center.x + translation.x,
                                        y: fruitImageView.center.y + translation.y)
        gesture.setTranslation(.zero, in: view)
        
        if gesture.state == .ended {
            checkIfInBasket(fruitImageView)
        }
    }
    
    func checkIfInBasket(_ fruitImageView: UIImageView) {
        for basket in basketers {
            if basket.frame.intersects(fruitImageView.frame) {
                if basket.color.rawValue == fruitImageView.tag {
                    // Успешно помещен в правильную корзину
                    fruitImageView.removeFromSuperview()
                    fruitImageViews.removeLast()
                } else {
                    // Неправильная корзина, вернуть фрукт на место
                    UIView.animate(withDuration: 0.3) {
                        fruitImageView.center = self.view.center
                    }
                }
                break
            }
        }
    }
}

enum FruitColor: Int {
    case red, yellow, blue, purple, green
    
    var uiColor: UIColor {
        switch self {
        case .red: return .red
        case .yellow: return .yellow
        case .blue: return .blue
        case .purple: return .purple
        case .green: return .green
        }
    }
}

class Fruit {
    let name: String
    let color: FruitColor
    init(name: String, color: FruitColor) {
        self.name = name
        self.color = color
    }
}

class Basket: UIView {
    let name: String
    let color: FruitColor
    init(name: String, color: FruitColor) {
        self.name = name
        self.color = color
        super.init(frame: .zero)
        let image = UIImageView(image: UIImage(named: name))
        image.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(image)
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            image.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
