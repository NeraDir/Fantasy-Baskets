//
//  levels.swift
//  Stak Fantasy
//
//  Created by Admin on 25.10.2024.
//

import Foundation
import UIKit

public class levels:UIViewController{
    
    let imageCount = 10 // Количество изображений
    let imageNames = ["item1", "item2", "item3", "item4", "item6", "item7", "item8"]
    var imageViews: [UIImageView] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        bg()
        images()

        label()
        closeButton()
        levelButtons()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateImages()
    }
    private func label(){
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.minimumScaleFactor = 0.001
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Futura-Bold", size: 300)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "LEVELS"
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 110),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -110),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            label.heightAnchor.constraint(equalToConstant: 80),
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
    
    private func levelButtons(){
            let numberOfButtons = 24
            let buttonsPerRow = 4
            let buttonWidth: CGFloat = 75
            let buttonHeight: CGFloat = 75
            let spacing: CGFloat = 5
            
            let totalWidth = CGFloat(buttonsPerRow) * buttonWidth + CGFloat(buttonsPerRow - 1) * spacing
            let totalHeight = CGFloat(numberOfButtons / buttonsPerRow) * buttonHeight + CGFloat((numberOfButtons / buttonsPerRow) - 1) * spacing
            let startX = (self.view.frame.width - totalWidth) / 2
            let startY = (self.view.frame.height - totalHeight) / 2 + 40
            
            for i in 0..<numberOfButtons {
                let row = i / buttonsPerRow
                let column = i % buttonsPerRow
                
                let xPosition = startX + CGFloat(column) * (buttonWidth + spacing)
                let yPosition = startY + CGFloat(row) * (buttonHeight + spacing)
                
                let button = UIButton(type: .system)
                button.frame = CGRect(x: xPosition, y: yPosition, width: buttonWidth, height: buttonHeight)
                button.tag = i
                button.contentMode = .scaleToFill
                button.layer.zPosition = 4
                button.contentMode = .scaleAspectFit
                button.tintColor = nil
                button.setBackgroundImage(UIImage(named:"bt4"), for: .normal)
                button.addTarget(self, action: #selector(OnButonPressed(_:)), for: [.touchUpInside,.touchUpOutside])
                
                if i > data.GetMaxLevel(){
                    let lockerImage = UIImageView(image: UIImage(named: "locker2"))
                    lockerImage.layer.zPosition = 5
                    lockerImage.contentMode = .scaleAspectFit
                    lockerImage.translatesAutoresizingMaskIntoConstraints = false
                    button.addSubview(lockerImage)
                    NSLayoutConstraint.activate([
                        lockerImage.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 0),
                        lockerImage.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 0),
                        lockerImage.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                        lockerImage.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                        lockerImage.topAnchor.constraint(equalTo: button.topAnchor, constant: 0),
                        lockerImage.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 0)
                    ])
                }
                else{
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.text = "\(button.tag + 1)"
                    label.textAlignment = .center
                    label.textColor = .white
                    label.contentMode = .scaleAspectFit
                    label.minimumScaleFactor = 0.001
                    label.adjustsFontSizeToFitWidth = true
                    label.layer.zPosition = 2
                    label.font = UIFont(name: "Futura-Bold", size: 300)
                    button.addSubview(label)
                    NSLayoutConstraint.activate([
                        label.leadingAnchor.constraint(equalTo: button.safeAreaLayoutGuide.leadingAnchor, constant: 5),
                        label.trailingAnchor.constraint(equalTo: button.safeAreaLayoutGuide.trailingAnchor, constant: -5),
                        label.topAnchor.constraint(equalTo: button.safeAreaLayoutGuide.topAnchor, constant: 5),
                        label.bottomAnchor.constraint(equalTo: button.safeAreaLayoutGuide.bottomAnchor, constant: -5),
                    ])
                }
                
                self.view.addSubview(button)
            }
        }
    
    private func closeButton(){
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.layer.zPosition = 1
        button.setBackgroundImage(UIImage(named: "bt4"), for: .normal)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "X"
        label.textAlignment = .center
        label.textColor = .white
        label.contentMode = .scaleAspectFit
        label.minimumScaleFactor = 0.001
        label.adjustsFontSizeToFitWidth = true
        label.layer.zPosition = 2
        label.font = UIFont(name: "Futura-Bold", size: 300)
        button.tag = -5
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
        if  sender.tag > -1{
            let vc = game()
            vc.leveValue = sender.tag
            openController(viewController: vc)
        }
        else{
            openController(viewController: menu())
        }
    }
    
    private func openController(viewController: UIViewController){
        let vc = viewController
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.hidesBackButton = true
        self.present(vc, animated: true)
    }
}
