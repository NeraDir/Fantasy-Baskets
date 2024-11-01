//
//  menu.swift
//  Stak Fantasy
//
//  Created by Admin on 20.10.2024.
//

import Foundation
import UIKit

public class menu:UIViewController{
    
    private let label: UILabel = UILabel()
    
    let imageCount = 10 // Количество изображений
    let imageNames = ["item1", "item2", "item3", "item4", "item6", "item7", "item8"]
    var imageViews: [UIImageView] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bg()
        images()

        buttons()
        about()
        logo()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateImages()
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
    
    private func logo(){
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        view.addSubview(logo)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.minimumScaleFactor = 0.001
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Futura-Bold", size: 300)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "COINS \n\(data.GetPlayerCoins())"
        logo.addSubview(label)
        
        NSLayoutConstraint.activate([
            logo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            logo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            logo.heightAnchor.constraint(equalToConstant: 140),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            label.leadingAnchor.constraint(equalTo: logo.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: logo.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: logo.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            label.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private func buttons(){
        let buttonTexts = ["SETTINGS","SHOP","LEVELS","PLAY"]
        var buttons: [UIButton] = []
        for i in 0...buttonTexts.count - 1{
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.contentMode = .scaleAspectFit
            button.layer.zPosition = 1
            button.setBackgroundImage(UIImage(named: "bt3"), for: .normal)
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = buttonTexts[i]
            label.textAlignment = .center
            label.contentMode = .scaleAspectFit
            label.minimumScaleFactor = 0.001
            label.adjustsFontSizeToFitWidth = true
            label.layer.zPosition = 2
            label.textColor = .white
            label.font = UIFont(name: "Futura-Bold", size: 300)
            button.tag = i
            button.addTarget(self, action: #selector(OnButonPressed(_:)), for: [.touchUpInside,.touchUpOutside])
            button.addSubview(label)
            
            view.addSubview(button)
            if buttons.count > 0 {
                NSLayoutConstraint.activate([
                    label.leadingAnchor.constraint(equalTo: button.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                    label.trailingAnchor.constraint(equalTo: button.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                    label.topAnchor.constraint(equalTo: button.safeAreaLayoutGuide.topAnchor, constant: 20),
                    label.bottomAnchor.constraint(equalTo: button.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                    button.widthAnchor.constraint(equalToConstant: data.widthBt),
                    button.heightAnchor.constraint(equalToConstant: data.heightBt),
                    button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
                    button.bottomAnchor.constraint(equalTo: buttons[buttons.count - 1].safeAreaLayoutGuide.topAnchor, constant: -5),
                ])
                buttons.append(button)
            }
            else{
                NSLayoutConstraint.activate([
                    label.leadingAnchor.constraint(equalTo: button.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                    label.trailingAnchor.constraint(equalTo: button.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                    label.topAnchor.constraint(equalTo: button.safeAreaLayoutGuide.topAnchor, constant: 20),
                    label.bottomAnchor.constraint(equalTo: button.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                    button.widthAnchor.constraint(equalToConstant: data.widthBt),
                    button.heightAnchor.constraint(equalToConstant: data.heightBt),
                    button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
                    button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
                ])
                buttons.append(button)
            }
        }
    }
    
    func images() {
            var frames: [CGRect] = [] // Сохраняем фреймы изображений, чтобы избежать наложения
            
            for i in 0..<imageCount {
                let randomImageName = imageNames[i % imageNames.count]
                guard let image = UIImage(named: randomImageName) else { continue }
                
                // Создание UIImageView с изображением
                let imageView = UIImageView(image: image)
                
                // Генерация случайного размера
                let rndzime = CGFloat.random(in: 50...100)
                let randomSize = CGSize(width: rndzime, height: rndzime)
                imageView.frame.size = randomSize
                
                // Генерация случайной позиции, проверка на наложение
                var randomFrame: CGRect
                repeat {
                    let randomX = CGFloat.random(in: 0...(view.bounds.width - randomSize.width))
                    let randomY = CGFloat.random(in: 0...(view.bounds.height - randomSize.height))
                    randomFrame = CGRect(origin: CGPoint(x: randomX, y: randomY), size: randomSize)
                } while frames.contains { $0.intersects(randomFrame) }
                
                frames.append(randomFrame)
                imageView.frame = randomFrame
                
                // Устанавливаем случайный угол поворота
                let randomRotation = CGFloat.random(in: 0...360) * (.pi / 180)
                imageView.transform = imageView.transform.rotated(by: randomRotation)
                
                // Добавляем UIImageView на экран и в массив
                view.addSubview(imageView)
                imageViews.append(imageView)
            }
        }
        
        func animateImages() {
            for (index, imageView) in imageViews.enumerated() {
                let delay = Double(index) * 0.15 // Задержка для последовательного старта анимации
                animateImageView(imageView, delay: delay)
            }
        }
        
        func animateImageView(_ imageView: UIImageView, delay: Double) {
            UIView.animate(
                withDuration: 1.5,
                delay: delay,
                options: [.autoreverse, .repeat],
                animations: {
                    // Движение вверх
                    imageView.center.y -= 50
                },
                completion: { _ in
                    // Возврат на место
                    imageView.center.y += 50
                }
            )
        }
    
    private func about(){
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.layer.zPosition = 1
        button.setBackgroundImage(UIImage(named: "bt4"), for: .normal)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "?"
        label.textAlignment = .center
        label.textColor = .white
        label.contentMode = .scaleAspectFit
        label.minimumScaleFactor = 0.001
        label.adjustsFontSizeToFitWidth = true
        label.layer.zPosition = 2
        label.font = UIFont(name: "Futura-Bold", size: 300)
        button.tag = 4
        button.addTarget(self, action: #selector(OnButonPressed(_:)), for: [.touchUpInside,.touchUpOutside])
        button.addSubview(label)
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: button.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: button.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: button.safeAreaLayoutGuide.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: button.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            button.widthAnchor.constraint(equalToConstant: data.squareBt),
            button.heightAnchor.constraint(equalToConstant: data.squareBt),
            button.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
        ])
        
        
    }
    
    @objc private func OnButonPressed(_ sender: UIButton){
        SoundPlayer.sharedInstance.player.play()
        switch sender.tag {
        case 0:
            openController(viewController: settings())
            break
        case 1:
            openController(viewController: shop())
            break
        case 2:
            openController(viewController: levels())
            break
        case 3:
            let vc = game()
            vc.leveValue = data.GetLevel()
            openController(viewController: vc)
            break
        case 4:
            openController(viewController: info())
            break
        default:
            break
        }
    }
    
    private func openController(viewController: UIViewController){
        let vc = viewController
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.hidesBackButton = true
        self.present(vc, animated: true)
    }
}
