//
//  info.swift
//  Stak Fantasy
//
//  Created by Admin on 20.10.2024.
//

import Foundation
import UIKit

public class info:UIViewController{
    
    private let toplabel: UILabel = UILabel()
    
    let imageCount = 10 // Количество изображений
    let imageNames = ["item1", "item2", "item3", "item4", "item6", "item7", "item8"]
    var imageViews: [UIImageView] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        closeButton()
        bg()
        images()

        label()
        character()
        labelinfo()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateImages()
    }
    private func label(){
        toplabel.translatesAutoresizingMaskIntoConstraints = false
        toplabel.minimumScaleFactor = 0.001
        toplabel.adjustsFontSizeToFitWidth = true
        toplabel.font = UIFont(name: "Futura-Bold", size: 300)
        toplabel.textColor = .white
        toplabel.textAlignment = .center
        toplabel.numberOfLines = 2
        toplabel.text = "HOW TO PLAY"
        view.addSubview(toplabel)
        
        NSLayoutConstraint.activate([
            toplabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 110),
            toplabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -110),
            toplabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            toplabel.heightAnchor.constraint(equalToConstant: 80),
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
    
    private func labelinfo(){
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.minimumScaleFactor = 0.001
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Futura-Bold", size: 300)
        label.textColor = .white
        label.textAlignment = .justified
        label.numberOfLines = 200
        label.text = "In this game, the player needs to quickly sort fruits into baskets. With each level, the number of fruits increases, and time becomes less. The task is to have time to distribute all the fruits correctly, without making mistakes, before the time runs out. The further the player advances, the more speed and attention is required to cope with the ever-increasing load."
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            label.topAnchor.constraint(equalTo: toplabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
    
    private func character(){
        let charac = UIImageView(image: UIImage(named: "ch"))
        charac.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(charac)
        
        NSLayoutConstraint.activate([
            charac.widthAnchor.constraint(equalToConstant: 150),
            charac.heightAnchor.constraint(equalToConstant: 150),
            charac.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            charac.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
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
        openController(viewController: menu())
    }
    
    private func openController(viewController: UIViewController){
        let vc = viewController
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.hidesBackButton = true
        self.present(vc, animated: true)
    }
}
