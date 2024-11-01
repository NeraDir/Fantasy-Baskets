//
//  shop.swift
//  Stak Fantasy
//
//  Created by Admin on 20.10.2024.
//

import Foundation
import UIKit

public class shop:UIViewController{
    
    private let bgnames: [String] = ["4","5","6","7","8","9"]
    private var bgbuttons: [UIButton] = []
    private let bg = UIImageView(image: UIImage(named: data.GetBGName()))
    
    let imageCount = 10 // Количество изображений
    let imageNames = ["item1", "item2", "item3", "item4", "item6", "item7", "item8"]
    var imageViews: [UIImageView] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        bge()
        images()

        closeButton()
        backgroundButtons()
        label()
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
        label.text = "SHOP"
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 90),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -90),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            label.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private func backgroundButtons(){
        let rows = 2
              let columns = 3

              let buttonWidth: CGFloat = 110
              let buttonHeight: CGFloat = 220
              let spacing: CGFloat = 10

              let gridWidth = CGFloat(columns) * buttonWidth + CGFloat(columns - 1) * spacing
              let gridHeight = CGFloat(rows) * buttonHeight + CGFloat(rows - 1) * spacing
              
              let startX = (view.frame.width - gridWidth) / 2
              let startY = (view.frame.height - gridHeight) / 2
              
              var index = 0

              for row in 0..<rows {
                  for column in 0..<columns {
                      let x = startX + CGFloat(column) * (buttonWidth + spacing)
                      let y = startY + CGFloat(row) * (buttonHeight + spacing)

                      let button = UIButton(frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight))
                      button.setBackgroundImage(UIImage(named: bgnames[index]), for: .normal)
                      button.tag = index
                      button.layer.borderWidth = 3
                      button.layer.cornerRadius = 10
                      button.layer.borderColor = CGColor(red: 0, green: 0, blue: 255, alpha: 1)
                      index += 1
                      button.addTarget(self, action: #selector(OnButonPressed(_:)), for: [.touchUpInside,.touchUpOutside])
                      bgbuttons.append(button)
                      view.addSubview(button)
                  }
              }
    }
    
    private func bge(){
       
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
        button.tag = 25
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
    
    @objc private func OnButonPressed(_ sender: UIButton){
        SoundPlayer.sharedInstance.player.play()
        if sender.tag < 20{
            data.SetBGName(value: bgnames[sender.tag])
            bg.image = UIImage(named: data.GetBGName())
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
